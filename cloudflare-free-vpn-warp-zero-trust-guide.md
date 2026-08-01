# Cloudflare 免费 VPN 教程：WARP 与 Zero Trust 私网接入

> 更新日期：2026-08-01

Cloudflare 提供两种接近 VPN 的免费方案：

- **个人使用：Cloudflare WARP**，加密设备到 Cloudflare 网络之间的流量。
- **远程访问私网：Cloudflare Zero Trust + Tunnel**，让手机和电脑安全访问家里、公司或云服务器的内网资源。

先说明限制：Cloudflare WARP 不是传统商业 VPN，不能手动选择美国、日本等出口国家，也不保证改变内容平台识别到的地区。

## 一、方案怎么选

| 需求 | 推荐方案 |
| --- | --- |
| 公共 Wi-Fi 下加密流量 | 免费 WARP |
| 改善部分线路的连接质量 | 免费 WARP |
| 远程访问家里的 NAS、SSH、RDP | Zero Trust + Tunnel |
| 团队访问公司内网 | Zero Trust + Tunnel |
| 自由选择不同国家出口 | Cloudflare WARP 不适合 |

## 二、最简单方案：安装免费 WARP

这种方式不需要购买服务器，也不需要域名。

### 1. 下载官方客户端

- [Cloudflare WARP 官方下载说明](https://developers.cloudflare.com/warp-client/get-started/)
- [Windows 安装说明](https://developers.cloudflare.com/warp-client/get-started/windows/)
- [Linux 安装说明](https://developers.cloudflare.com/warp-client/get-started/linux/)
- [macOS、Windows、Linux 稳定版下载](https://developers.cloudflare.com/cloudflare-one/team-and-resources/devices/cloudflare-one-client/download/)
- [iOS 和 Android：1.1.1.1 with WARP](https://one.one.one.one/)

只从 Cloudflare 官网、App Store 或 Google Play 下载，不要安装网盘里的修改版。

### 2. Windows 和 macOS

1. 下载并安装 Cloudflare WARP。
2. 打开客户端。
3. 阅读并接受隐私说明。
4. 将连接模式切换为 `WARP`。
5. 打开连接开关。

`WARP` 模式会加密并转发设备流量；`1.1.1.1` 模式主要保护 DNS 查询。需要类似 VPN 的效果时选择 `WARP`。

### 3. Android 和 iPhone

1. 从 Google Play 或 App Store 安装 `1.1.1.1 with WARP`。
2. 打开应用并允许创建 VPN 配置。
3. 选择 `WARP` 模式。
4. 打开连接开关。

手机系统会显示 VPN 图标，这是正常现象。

### 4. Linux

从 [Cloudflare 软件包仓库](https://pkg.cloudflareclient.com/)安装 `cloudflare-warp`。

Ubuntu、Debian 等 apt 系统安装好软件源后执行：

```bash
sudo apt update
sudo apt install cloudflare-warp
```

RHEL、CentOS 等 yum 系统安装好软件源后执行：

```bash
sudo yum install cloudflare-warp
```

首次连接：

```bash
warp-cli registration new
warp-cli connect
```

检查连接：

```bash
curl https://www.cloudflare.com/cdn-cgi/trace
```

返回内容中出现下面一行，说明 WARP 已连接：

```text
warp=on
```

断开连接：

```bash
warp-cli disconnect
```

## 三、进阶方案：搭建免费的私网 VPN

这个方案适合从外网访问 NAS、开发机、数据库、SSH、远程桌面和其他内网服务。

网络结构：

```text
手机或电脑
→ Cloudflare One Agent
→ Cloudflare 全球网络
→ Cloudflare Tunnel
→ 家庭、公司或云服务器私网
```

Cloudflare Tunnel 使用服务器主动向外建立连接的方式，通常不需要公网 IP，也不需要在路由器上开放入站端口。

## 四、创建 Cloudflare Zero Trust 免费组织

1. 注册并登录 [Cloudflare Dashboard](https://dash.cloudflare.com/)。
2. 进入 `Zero Trust`。
3. 创建一个 Team name，例如：

```text
my-home-network
```

4. 选择 Zero Trust Free 方案。
5. 按页面要求完成开通。

Cloudflare 官方说明，免费方案开通过程仍可能要求填写付款信息，但选择 Free 方案不会收取订阅费。提交前要再次确认页面显示的方案和金额。

## 五、配置设备登录

进入 Zero Trust 控制台：

1. 打开 `Settings` 或 `Team & Resources`。
2. 配置登录方式。
3. 可以直接使用 Cloudflare 账号，也可以启用邮箱一次性验证码。
4. 创建 Device enrollment rule。
5. 只允许自己的邮箱或指定团队成员注册设备。

不要创建“任何邮箱都能加入”的宽松规则，否则陌生人可能注册到你的组织。

官方配置说明：

- [Cloudflare One Client 首次配置](https://developers.cloudflare.com/cloudflare-one/team-and-resources/devices/cloudflare-one-client/set-up/)
- [身份提供商与一次性验证码](https://developers.cloudflare.com/cloudflare-one/integrations/identity-providers/)

## 六、创建 Cloudflare Tunnel

准备一台能访问私网资源的电脑、NAS、Linux 主机或云服务器。

1. 打开 Cloudflare Zero Trust 控制台。
2. 进入 `Networking > Tunnels`。
3. 点击 `Create a tunnel`。
4. 选择 `cloudflared`。
5. 输入名称，例如 `home-lan`。
6. 选择服务器操作系统。
7. 复制页面生成的安装和启动命令。
8. 在服务器终端里执行。
9. 等待控制台显示 `Healthy`。

建议使用控制台生成的命令，因为里面包含该 Tunnel 专属的认证 Token，不要把这个命令或 Token 发给别人。

安装包入口：

- [cloudflared 官方下载](https://developers.cloudflare.com/tunnel/downloads/)
- [cloudflared GitHub Releases](https://github.com/cloudflare/cloudflared/releases/latest)
- [创建 Tunnel 官方教程](https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/get-started/create-remote-tunnel/)

## 七、添加私网路由

假设需要访问的家庭局域网是：

```text
192.168.1.0/24
```

在 Zero Trust 控制台中：

1. 进入 `Networking > Routes`。
2. 点击 `Create route`。
3. 选择 `Tunnel CIDR`。
4. 选择刚才创建的 Tunnel。
5. 在 Network 中填写 `192.168.1.0/24`。
6. 保存路由。

如果只想开放一台设备，可以填写单个 IP，例如：

```text
192.168.1.10/32
```

范围越小越安全。不要在不了解影响时填写 `0.0.0.0/0`。

官方路由教程：

- [Connect an IP/CIDR](https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/private-net/cloudflared/connect-cidr/)

## 八、调整 Split Tunnels

WARP 默认可能排除 `192.168.0.0/16`、`10.0.0.0/8` 等私网地址，所以只创建 Tunnel 路由还不一定能访问。

进入 Cloudflare One Client 的设备配置：

1. 找到 `Split Tunnels`。
2. 查看当前是 Include 还是 Exclude 模式。
3. 确保目标私网 CIDR 会进入 WARP Tunnel。
4. 保存并等待设备配置刷新。

如果本地当前网络和远程网络都使用 `192.168.1.0/24`，会发生地址冲突。可以修改其中一边的网段，或者使用 Cloudflare Virtual Network 隔离重叠路由。

## 九、安装并注册客户端

在需要远程接入的电脑或手机上安装 Cloudflare One Agent：

- [Cloudflare One Client 稳定版](https://developers.cloudflare.com/cloudflare-one/team-and-resources/devices/cloudflare-one-client/download/)

打开客户端后：

1. 选择登录 Cloudflare Zero Trust。
2. 输入之前创建的 Team name。
3. 使用允许的邮箱或身份提供商登录。
4. 连接成功后确认客户端显示 `Connected`。

然后测试私网服务：

```bash
ssh user@192.168.1.10
```

也可以在浏览器打开 NAS 或内网管理页面：

```text
http://192.168.1.10
```

## 十、安全设置

- Device enrollment rule 只允许指定邮箱。
- 给不同用户创建最小权限的 Gateway 策略。
- 只添加确实需要访问的单个 IP 或小范围 CIDR。
- 不公开 Tunnel Token。
- 不要关闭 NAS、SSH、RDP 自身的密码和多因素认证。
- 定期在 `Team & Resources > Devices` 删除不再使用的设备。
- 开启 Cloudflare 账号两步验证。

Cloudflare Tunnel 只是安全通道，不会自动修复内网服务的弱密码或漏洞。

## 十一、常见问题

### WARP 已连接，但地区没有变化

这是正常的。WARP 重点是加密和网络路由，不提供国家节点选择。

### Tunnel 显示 Down 或 Inactive

检查运行 `cloudflared` 的服务器能否访问外网，以及防火墙是否允许出站 TCP/UDP `7844` 端口。

新版本可以运行：

```bash
cloudflared tunnel diag
```

### 客户端已连接，但访问不了内网 IP

依次检查：

1. Tunnel 是否为 `Healthy`。
2. CIDR 路由是否指向正确 Tunnel。
3. Split Tunnels 是否包含目标私网。
4. 服务器本身能否访问目标内网 IP。
5. Gateway 策略是否阻止了连接。

### 本地和远程网段冲突

修改一侧的局域网网段，或使用 Virtual Network。两个网络都使用 `192.168.1.0/24` 时，系统通常会优先访问本地网络。

## 十二、总结

只想免费加密日常网络：

```text
安装 WARP → 选择 WARP 模式 → 打开连接
```

想远程访问自己的私网：

```text
创建 Zero Trust 免费组织
→ 配置设备注册规则
→ 创建 Cloudflare Tunnel
→ 添加私网 CIDR
→ 配置 Split Tunnels
→ 安装 Cloudflare One Agent
→ 登录并访问内网
```

## 资料来源

- [Cloudflare WARP 客户端文档](https://developers.cloudflare.com/warp-client/get-started/)
- [Cloudflare One Client 首次配置](https://developers.cloudflare.com/cloudflare-one/team-and-resources/devices/cloudflare-one-client/set-up/)
- [Cloudflare Zero Trust 快速开始](https://developers.cloudflare.com/cloudflare-one/setup/)
- [Cloudflare 私网连接说明](https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/private-net/)
- [Cloudflare Tunnel 创建教程](https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/get-started/create-remote-tunnel/)
- [Cloudflare 私网 CIDR 路由](https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/private-net/cloudflared/connect-cidr/)
