# 图床 + PicGo 配置指南

**图床选择建议：**
- GitHub 图床：免费，适合个人使用，配合 jsdelivr CDN 访问速度快
- 腾讯云 COS：付费，适合企业或对稳定性要求高的场景
- 建议根据实际需求选择其中一种方案即可

**CDN 加速说明：**
- 本配置使用 jsdelivr CDN 进行全球加速
- 图片链接格式：`https://cdn.jsdelivr.net/gh/用户名/仓库名@分支名/图片路径`
- 例如：`https://cdn.jsdelivr.net/gh/wilesanGH/PicGo@master/img/example.png`
- 优点：访问速度快，全球可用，无需额外配置

## 1. 腾讯云 COS 配置

### 1.1 创建存储桶

1. 登录腾讯云控制台
2. 进入对象存储 COS
3. 点击"创建存储桶"
4. 配置存储桶信息：
   > 名称：自定义（建议使用小写字母和数字）
   >
   > 地域：选择离你最近的区域
   >
   > 访问权限：建议选择"私有读写"
   >
   > 其他选项保持默认即可

### 1.2 获取密钥信息

1. 在腾讯云控制台右上角点击"访问管理"
2. 选择"访问密钥" > "API 密钥管理"
3. 创建新的密钥，保存以下信息：
   > SecretId
   >
   > SecretKey

## 2. GitHub 图床配置

### 2.1 创建 GitHub 仓库

1. 登录 GitHub 账号
2. 点击右上角 "+" 按钮，选择 "New repository"
3. 填写仓库信息：
   > 仓库名称：自定义（建议使用小写字母和数字）
   >
   > 描述：可选
   >
   > 选择 "Public" 或 "Private"（建议使用 Public）
   >
   > 初始化仓库时不要添加 README 文件

### 2.2 生成 GitHub Token

1. 点击 GitHub 右上角头像，选择 "Settings"
2. 在左侧菜单选择 "Developer settings"
3. 选择 "Personal access tokens" > "Tokens (classic)"
4. 点击 "Generate new token"
5. 设置权限：
   
   > 选择 "repo" 权限
   >
   > 设置 token 过期时间
   >
   > 生成并保存 token（只会显示一次）

![image-20250430132621130](./../../png/%E5%9B%BE%E5%BA%8A%E9%85%8D%E7%BD%AE+PicGo/image-20250430132621130.png)

### 2.3 PicGo 配置 GitHub 图床

1. 打开 PicGo
2. 在图床设置中选择 "GitHub"
3. 填写配置信息：
   > 仓库名：填写你的 GitHub 用户名/仓库名
   >
   > 分支名：填写 "main" 或 "master"
   >
   > Token：填写生成的 GitHub Token
   >
   > 存储路径：可自定义（如：images/）
   >
   > 自定义域名：可选，建议使用 jsdelivr CDN 加速

![image-20250430132656191](https://cdn.jsdelivr.net/gh/wilesanGH/PicGo@master/img/image-20250430132656191.png)

### 2.4 使用说明

1. 上传图片：
   > 直接拖拽图片到 PicGo 窗口
   >
   > 或使用截图工具截图后自动上传
2. 获取链接：
   > 上传成功后，链接会自动复制到剪贴板
   >
   > 可以直接粘贴到 Markdown 文档中

### 2.5 注意事项

1. 确保 GitHub Token 的安全性，不要泄露
2. 建议使用 jsdelivr CDN 加速访问
3. 注意仓库大小限制
4. 定期检查 Token 是否过期

### 2.6 Typora 配置上传图片到 GitHub

1. 打开 Typora
2. 点击菜单栏的 "文件" > "偏好设置"
3. 在左侧选择 "图像"
4. 配置上传服务：

> 选择 "上传图片" 选项
>
> 上传服务选择 "PicGo (app)"
>
> 点击 "验证图片上传选项" 确保配置正确

![image-20250430133210282](https://cdn.jsdelivr.net/gh/wilesanGH/PicGo@master/img/image-20250430133210282.png)

```json
{
  "picBed": {
    "current": "github",
    "uploader": "github",
    "github": {
      "repo": "wilesanGH/PicGo",
      "branch": "master",
      "token": "*******************************",
      "path": "img/",       
      "customUrl": "https://cdn.jsdelivr.net/gh/wilesanGH/PicGo@master"
    }
  },
  "picgoPlugins": {
    "picgo-plugin-rename-file": true
  },
  "rename-file": {
    "format": "{year}/{month}/{day}/{hour}{minute}{second}-{hash}"
  },
  "beforeUploadPlugins": ["rename-file"],
  "settings": {
    "uploadNotification": true
  }
}

```

这个里面原本希望和picGo里面一样用picgo-plugin-rename-file自动重命名，没有效果，配置可能还有问题

1. 设置插入图片时的行为：

   粘贴图片到typora里面后，在图片上点击右键，upload image会自动上传到对应的gh库，图片的链接也会更新。

   ![image-20250430133558316](https://cdn.jsdelivr.net/gh/wilesanGH/PicGo@master/img/image-20250430133558316.png)
2. 使用说明：
   > 图片不可以重复上传，会有sha验证，同一个图片hash是一样的，会报错。

## 3. PicGo 配置

### 3.1 安装 PicGo

1. 访问 [PicGo 官方仓库](https://github.com/Molunerfinn/PicGo/releases)
2. 下载并安装适合你系统的版本

### 3.2 配置腾讯云 COS

1. 打开 PicGo
2. 在图床设置中选择"腾讯云 COS"
3. 填写配置信息：
   > SecretId：填写你的 SecretId
   >
   > SecretKey：填写你的 SecretKey
   >
   > Bucket：填写你的存储桶名称
   >
   > Region：填写存储桶所在区域（如：ap-guangzhou）
   >
   > 存储路径：可自定义（如：images/）
   >
   > 自定义域名：可选，建议填写 COS 的访问域名

![image-20250430132754178](https://cdn.jsdelivr.net/gh/wilesanGH/PicGo@master/img/image-20250430132754178.png)

### 3.3 使用说明

1. 上传图片：
   > 直接拖拽图片到 PicGo 窗口
   >
   > 或使用截图工具截图后自动上传
2. 获取链接：
   > 上传成功后，链接会自动复制到剪贴板
   >
   > 可以直接粘贴到 Markdown 文档中

## 4. 注意事项

1. 确保存储桶的访问权限设置正确
2. 定期检查 API 密钥的安全性
3. 建议开启存储桶的防盗链功能
4. 注意控制存储空间的使用量，避免产生额外费用

## 5. 常见问题

1. 上传失败：
   > 检查 API 密钥是否正确
   >
   > 确认存储桶名称和区域是否正确
   >
   > 检查网络连接是否正常
   
2. 图片无法访问：
   > 检查存储桶的访问权限
   >
   > 确认自定义域名是否配置正确
   >
   > 检查防盗链设置是否过于严格
   
3. 图片重命名问题：
   > 安装 picgo-plugin-rename-file 插件
   >
   > 在 PicGo 设置中启用该插件
   >
   > 可自定义图片重命名规则，避免文件名冲突
   >
   > 支持使用时间戳、随机字符等多种命名方式