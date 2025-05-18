# U8g2Kit

[![Swift](https://img.shields.io/badge/Swift-5.10-orange.svg)](https://swift.org)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

U8g2Kit 是一个用于 Swift 的 U8g2 图形库封装，它提供了简单易用的 API 来驱动各种 OLED 显示屏。本项目基于著名的 [U8g2](https://github.com/olikraus/u8g2) 库，并添加了 Swift 的原生支持。

## ✨ 特性

- 🚀 完整的 U8g2 功能支持
- 📱 支持多种 OLED 显示屏
- 🎮 内置 SDL2 模拟器，方便开发和调试
- 🛠 简单易用的 Swift API
- 📦 Swift Package Manager 支持

## 📋 系统要求

- Swift 5.10 或更高版本
- Linux
- 支持 SDL2 的系统环境

## 📦 安装

### Swift Package Manager

在您的 `Package.swift` 文件中添加以下依赖：

```swift
dependencies: [
    .package(url: "https://github.com/CmST0us/U8g2Kit.git", branch: "main")
]
```

## 🚀 快速开始

```swift
import U8g2Kit
import CU8g2

// 创建自定义驱动
class MyDriver: Driver {
    init() {
        // 使用 u8g2_SetupBuffer_SDL_256x128 作为示例
        super.init(u8g2_SetupBuffer_SDL_256x128, &u8g2_cb_r0)
    }
}

// 初始化驱动
let driver = MyDriver()

// 初始化显示
driver.withUnsafeU8g2 { u8g2 in
    u8g2_InitDisplay(u8g2)
}

// 绘制内容
driver.withUnsafeU8x8 { u8x8 in
    u8x8_ClearDisplay(u8x8)
    u8x8_SetFont(u8x8, u8x8_font_7x14_1x2_f)
    u8x8_Draw1x2String(u8x8, 0, 0, "Hello World!")
    u8x8_Draw2x2String(u8x8, 0, 4, "Hello World!")
}
```

## 🎮 模拟器

U8g2Kit 包含一个基于 SDL2 的模拟器，可以帮助您在开发过程中进行调试。模拟器提供了一个 256x128 的显示窗口，并支持基本的显示功能：

```swift
import U8g2Kit
import CU8g2
import SDL2

// 创建 SDL2 驱动
class SDL2Driver: Driver {
    init() {
        super.init(u8g2_SetupBuffer_SDL_256x128, &u8g2_cb_r0)
    }
}

// 初始化并运行模拟器
let driver = SDL2Driver()
driver.withUnsafeU8g2 { u8g2 in
    u8g2_InitDisplay(u8g2)
}

// 在模拟器中绘制内容
driver.withUnsafeU8x8 { u8x8 in
    u8x8_ClearDisplay(u8x8)
    u8x8_SetFont(u8x8, u8x8_font_7x14_1x2_f)
    u8x8_Draw1x2String(u8x8, 0, 0, "Hello World!")
    u8x8_Draw2x2String(u8x8, 0, 4, "Hello World!")
}
```

## 📚 文档

详细的 API 文档请参考 [Documentation](docs/API.md)。

## 🤝 贡献

欢迎提交 Pull Request 和 Issue！

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。
