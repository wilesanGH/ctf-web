| 状态码      | 名称                          | 说明                                                         |
| ----------- | ----------------------------- | ------------------------------------------------------------ |
| 1xx****     | **信息性状态码**              | **请求已接收，服务器正在处理。**                             |
| 100         | Continue                      | 请求已接收，客户端应继续发送请求的其余部分。                 |
| 101         | Switching Protocols           | 服务器理解请求并准备切换协议（如从 HTTP/1.1 到  HTTP/2 或 WebSocket）。 |
| **2xx**     | **成功状态码**                | **请求已成功被服务器接收、理解并处理。**                     |
| 200         | OK                            | 请求成功，通常与 GET 或 POST 请求一起使用。                  |
| 201         | Created                       | 请求成功并且服务器创建了新的资源。                           |
| 202         | Accepted                      | 请求已接受，但服务器尚未处理。                               |
| 203         | Non-Authoritative Info        | 请求成功，返回的数据来自缓存或代理服务器，而非原始服务器。   |
| 204         | No Content                    | 请求成功，但没有返回任何内容。                               |
| 205         | Reset Content                 | 请求成功，要求客户端重置视图（如清空表单输入）。             |
| 206         | Partial Content               | 请求成功，返回部分资源，通常用于范围请求。                   |
| 3xx****     | **重定向状态码**              | **客户端需要进一步操作才能完成请求，通常是重定向或提供其他资源位置。** |
| 300         | Multiple Choices              | 请求有多种选择，客户端可以选择一个响应。                     |
| 301         | Moved Permanently             | 请求的资源已被永久移动到新 URL。                             |
| 302         | Found                         | 请求的资源临时移动到新位置，客户端应继续使用原始 URL。       |
| 303         | See Other                     | 客户端应使用另一个 URL 获取请求的资源，通常在 POST  请求后重定向至 GET 请求。 |
| 304         | Not Modified                  | 资源未被修改，客户端可以使用缓存的资源。                     |
| 305         | Use Proxy                     | 请求应通过指定的代理服务器访问资源（该状态码已不推荐使用）。 |
| 307         | Temporary Redirect            | 临时重定向，客户端应使用原请求方法，保持方法不变。           |
| 308         | Permanent Redirect            | 永久重定向，客户端应使用新 URL，保持请求方法不变。           |
| **4xx**     | **客户端错误状态码**          | **客户端的请求存在问题，通常是请求无效或缺少必要参数。**     |
| 400         | Bad Request                   | 请求无效，服务器无法理解请求格式。                           |
| 401         | Unauthorized                  | 请求未经授权，需提供身份认证信息。                           |
| 402         | Payment Required              | 请求需要支付费用，通常是预留给需要付费的服务（已不常用）。   |
| 403         | Forbidden                     | 服务器理解请求，但拒绝执行。客户端没有权限访问该资源。       |
| 404         | Not Found                     | 请求的资源未找到。                                           |
| 405         | Method Not Allowed            | 请求方法不被允许，通常是请求方法不支持该资源（如 POST  请求某个只允许 GET 的资源）。 |
| 406         | Not Acceptable                | 请求的资源类型不被接受。                                     |
| 407         | Proxy Authentication Required | 需要通过代理服务器进行身份验证。                             |
| 408         | Request Timeout               | 请求超时，客户端未在服务器规定的时间内完成请求。             |
| 409         | Conflict                      | 请求与服务器的当前状态发生冲突。                             |
| 410         | Gone                          | 请求的资源已永久删除，不再可用。                             |
| 411         | Length Required               | 请求头中缺少 Content-Length 参数。                           |
| 412         | Precondition Failed           | 请求的先决条件失败（如请求头的 If-Modified-Since 失败）。    |
| 413         | Payload Too Large             | 请求体过大，服务器无法处理。                                 |
| 414         | URI Too Long                  | 请求的 URL 过长，服务器无法处理。                            |
| 415         | Unsupported Media Type        | 请求的媒体类型不被支持。                                     |
| 416         | Range Not Satisfiable         | 请求的资源部分不可用，超出了服务器支持的范围。               |
| 417         | Expectation Failed            | 服务器无法满足请求头中的 Expect 期望值。                     |
| **5xx****** | **服务器错误状态码**          | **服务器未能完成有效请求，通常是服务器本身存在问题。**       |
| 500         | Internal Server Error         | 服务器内部错误，无法完成请求。                               |
| 501         | Not Implemented               | 服务器不支持请求的功能或方法。                               |
| 502         | Bad Gateway                   | 服务器作为网关或代理时，接收到无效的响应。                   |
| 503         | Service Unavailable           | 服务器当前不可用，通常由于过载或停机维护。                   |
| 504         | Gateway Timeout               | 作为网关或代理的服务器没有及时从上游服务器收到响应。         |
| 505         | HTTP Version Not Supported    | 服务器不支持请求中所使用的 HTTP 协议版本。                   |