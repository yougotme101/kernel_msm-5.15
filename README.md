# 🚀 Android Kernel Builder
## ⚠️ Important Notice

This workflow is configured for specific devices. **You must modify the settings for your device** or it may not work properly.

## Extra Optimization (Only for test-a workflow)
- Added Extra TCP Congestion: BBR, Cubic, Westwood
- Added KSU Fork: KowSU, MamboSU
- Added Custom Tickrate Options: 500hz, 600hz, 750hz
- Added options to build with BBG
- FullLTO build
- Add Swapfile options and Cleanup Disk tools to free up space for runners
- Added XStock, update weekly (basically YASK, but i changed the the default manager to WildKSU, bring back BBG Support, and remove KPM Feature for SukiSU)

## 🔧 Quick Start

1. **Fork this repository**
2. Go to **Actions** tab → **"Build kernels test-a"** workflow
3. Click **"Run workflow"** and configure:

### Workflow Settings (Use test-a to get more options)

| Setting | Description | Default |
|---------|-------------|---------|
| **Kernel source URL** | Your kernel repository URL | `https://github.com/topnotchfreaks/kernel_msm-5.15` |
| **Kernel branch** | Branch to build from | `codelinaro` |
| **Device** | Device name for defconfig | `gki` |
| **Custom localversion** | Add custom version suffix | (empty) |
| **Build KSU variant** | Include KernelSU version | `true` |
| **KSU variant** | KernelSU Manager | `KowSU` |
| **Kernel Optmization** | Optimization Level | `02` |
| **LTO mode** | Optimization level | `full` |
| **Tickrate** | Custom Tickrate Options | `250` |
| **BBG** | Add BBG Support | `on` |
| **Swap for runners** | To prevent workflows from failed cause running out of space | `8GB` |
4. **Wait for build** (20-40 minutes)
5. **Download** the flashable ZIP from artifacts

## 📱 Telegram Notifications (Optional)

Get build results sent to Telegram:

1. Create a bot with [@BotFather](https://t.me/BotFather)
2. Get your chat ID from [@GetIDsBot](https://t.me/GetIDsBot)
3. Add these secrets in repository **Settings** → **Secrets**:
   - `TELEGRAM_BOT_TOKEN`
   - `TELEGRAM_USER_ID`

## 🤝 Credits

- **@PhamtomK12** – Original builder
- **@ssocozy** – Contributor  
- **@NVG-064** – Contributor
- **@ShirkNeko** – SUSFS integration
- **@RapliVx** - Multi Manager support script
- **@Koneko_dev** - Some helps

---

**Ready to build? Hit that "Run workflow" button! 🎉**
| **LTO mode** | Optimization level | `full` |

4. **Wait for build** (20-40 minutes)
5. **Download** the flashable ZIP from artifacts

## 📱 Telegram Notifications (Optional)

Get build results sent to Telegram:

1. Create a bot with [@BotFather](https://t.me/BotFather)
2. Get your chat ID from [@GetIDsBot](https://t.me/GetIDsBot)
3. Add these secrets in repository **Settings** → **Secrets**:
   - `TELEGRAM_BOT_TOKEN`
   - `TELEGRAM_USER_ID`
