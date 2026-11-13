# 港版 iPhone + 美国 eSIM：低成本保号指南

> 更新日期：2026-11-13

在香港购买**支持 eSIM 的无锁 iPhone**，可选择支持境外开通的美国号码服务，持续续费保号。先区分“能在香港开通”和“能通过指定平台验证”，两者不是一回事。

## 1. 买手机先确认 eSIM

- 港版并非全系列支持 eSIM，部分型号使用双实体 SIM。购买前查[Apple 官方型号说明](https://support.apple.com/en-gb/108898)。
- 到店确认 `设置 → 蜂窝网络 → 添加 eSIM`，并在“关于本机”查看 EID。
- 选择无运营商锁的设备，购买号码前再通过运营商的 IMEI 兼容性检查。

已有兼容手机的用户，无需专门去香港换机。

## 2. 可在香港使用的境外开通方案：Saily

[Saily 美国号码](https://saily.com/esim-phone-number/)可在境外申请，无需赴美；官方也提供[香港 eSIM 套餐](https://saily.com/esim-hong-kong/)。美国号码是单独购买的附加服务，不能只买流量包。

办理步骤：

1. 从官网下载 Saily App，确认手机兼容。
2. 进入 `Phone number / Get phone number`，选择美国 `+1` 号码订阅。
3. 用本人合资格证件完成身份验证，再按 App 指引激活。
4. 如需香港上网，另购香港流量套餐，安装 eSIM 并开启该线路的数据漫游。
5. 在 Saily App 中测试短信，确认实际收码情况，再持续续费。

**费用：**号码产品页标示 US$0.99/月起，官方境外购号文章则列出 US$1.99/月，通话短信包另有 US$0.99 起的选项。不同订阅周期或页面报价存在差异，以 App 结账页为准；流量、号码、通话短信分别核对，不能把最低号码价当作全部费用。[官方境外开通说明](https://saily.com/blog/how-to-get-a-us-phone-number/)

**用于 Claude 的限制：**Saily 官方帮助中心明确说明号码由使用 VoIP 技术的运营商提供，部分平台会识别为 VoIP 并拒绝验证码。Claude 不接受 VoIP 号码，因此不要仅为 Claude 验证购买此方案；是否能收到普通短信不代表能完成 Claude 验证。[Saily 验证码兼容说明](https://support.saily.com/hc/en-us/articles/27948689277596-Can-I-use-Saily-phone-number-for-OTP-and-2FA)

## 3. 需在美国首次激活的方案：Tello

[Tello 自选套餐](https://tello.com/buy/custom_plans/)目前有约 **US$5/月**的无流量语音短信档，按月计算约 US$60/年；具体额度、税费和价格以结账页为准。

**购买前必看：Tello 官方目前要求首次 eSIM 激活必须在美国连接当地基站，不能直接在香港或其他境外地区完成首次激活。**仅在香港买到兼容手机，并不意味着马上就能使用这项套餐。[首次激活要求](https://tello.com/help_center/international-calls/can-i-activate-my-esim-outside-the-us)

没有赴美安排时，不要把 Tello 当作可在香港直接首次激活的方案。

## 4. Tello 激活后在境外收短信

1. 按运营商要求完成激活，测试通话和短信。
2. 在运营商账户中完成 Wi-Fi Calling 设置及所需的美国紧急服务地址信息，如实填写。
3. 在 iPhone 的该号码设置中开启 `Wi-Fi 通话`。
4. 在境外连接可用 Wi-Fi，测试普通短信，再测试所需平台的验证码。
5. 设置续费提醒或自动续费，保持套餐有效，避免号码被回收。

Tello 支持通过 Wi-Fi Calling 在境外收发短信，但网络和发送方可能有限制，不能保证每个平台的验证码都能收到。[官方说明](https://tello.com/help_center/service-issues-troubleshooting/how-can-i-use-wi-fi-calling)

## 5. 注册 ChatGPT、Claude 时注意

- **ChatGPT：**普通注册和使用通常不要求手机号；有验证提示时按页面要求办理，不必仅为普通注册购买美国号码。[OpenAI 说明](https://help.openai.com/en/articles/8983040-what-does-phone-verification-look-like)
- **Claude：**官方要求受支持地区、能接收短信的号码，不接受 Google Voice、VoIP 等号码；美国运营商号码也不保证通过。[Claude 号码验证说明](https://support.claude.com/en/articles/8287232-verify-your-phone-number)
- 纯流量旅行 eSIM 通常没有可接短信的手机号，购买前确认套餐包含号码及短信功能。
- 美国号码不改变实际所在地，也不替代平台的服务地区资格要求。

**购买顺序：确认手机型号 → 确认激活地点 → 选择可收短信的套餐 → 测试收码 → 持续续费。**
