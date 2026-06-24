---
name: 搭个话
description: 对话信号流 IM 客户端设计系统
colors:
  ink: "#101820"
  muted-ink: "#4F6070"
  canvas: "#F3F7F9"
  surface: "#FFFFFF"
  fog: "#EAF1F4"
  line: "#D7E0E8"
  signal: "#0E7C7B"
  signal-soft: "#DFF2EF"
  pulse: "#D95F48"
  pulse-soft: "#FBE9E4"
  orbit: "#315ED8"
  orbit-soft: "#E7EDFD"
  amber: "#9B6A05"
  amber-soft: "#FFF2D4"
typography:
  display:
    fontFamily: "system-ui, -apple-system, BlinkMacSystemFont, sans-serif"
    fontSize: "28px"
    fontWeight: 800
    lineHeight: 1.12
    letterSpacing: "0"
  title:
    fontFamily: "system-ui, -apple-system, BlinkMacSystemFont, sans-serif"
    fontSize: "17px"
    fontWeight: 800
    lineHeight: 1.24
  body:
    fontFamily: "system-ui, -apple-system, BlinkMacSystemFont, sans-serif"
    fontSize: "14px"
    fontWeight: 400
    lineHeight: 1.45
  label:
    fontFamily: "system-ui, -apple-system, BlinkMacSystemFont, sans-serif"
    fontSize: "12px"
    fontWeight: 700
    lineHeight: 1.2
rounded:
  sm: "6px"
  md: "8px"
  pill: "999px"
spacing:
  xs: "4px"
  sm: "8px"
  md: "12px"
  lg: "16px"
  xl: "24px"
components:
  button-primary:
    backgroundColor: "{colors.signal}"
    textColor: "{colors.surface}"
    rounded: "{rounded.md}"
    padding: "10px 14px"
  card-surface:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.ink}"
    rounded: "{rounded.md}"
    padding: "14px"
  chip-selected:
    backgroundColor: "{colors.signal-soft}"
    textColor: "{colors.signal}"
    rounded: "{rounded.pill}"
    padding: "5px 9px"
---

# Design System: 搭个话

## 1. Overview

**Creative North Star: "Signal Loom"**

搭个话的界面像一张正在编织的对话信号网：消息、关系、资产和运营配置不是分散模块，而是沿着可扫描的状态路径展开。设计基调是清醒、轻巧、有信号感，避免传统熟人社交的绿色克隆，也避免深色霓虹控制台。

这是产品 UI，不是营销页。视觉识别来自稳定的组件语言、轻量的信号轨道、明确的状态徽标和克制的色彩比例。新颖只出现在能提升理解的位置：连接状态、会话优先级、功能地图和验收状态。

**Key Characteristics:**
- 高扫描效率：头像、标题、摘要、状态、动作形成连续阅读路径。
- 状态优先：未读、失败、审核、锁定、权限不足都有文字或图标。
- 轻质结构：用边界、色块和轨道表达层级，默认不靠大阴影。
- 默认数据真实：演示内容覆盖 IM、钱包、朋友圈、商品、设置和运营开关。

## 2. Colors

调色板采用冷雾背景、深墨文字、信号青主色、脉冲橙红、轨道蓝和少量琥珀状态色。

### Primary
- **Signal Teal**: 主操作、当前导航、在线连接、关键可操作状态。

### Secondary
- **Pulse Coral**: 未读、失败、强提醒和需要处理的事件。
- **Orbit Blue**: 置顶、稳定连接、信息态和系统路径。

### Tertiary
- **Amber Checkpoint**: 审核、更新、下载和配置提醒。

### Neutral
- **Ink**: 主文本和重要标题。
- **Muted Ink**: 次级说明、时间和辅助信息。
- **Cool Canvas**: 页面底色，保持干净冷静，不走奶油色模板。
- **Surface / Fog / Line**: 卡片、输入、导航和分隔边界。

### Named Rules

**The Signal Ratio Rule.** Signal Teal 在单屏面积中不要超过 10%，只用于当前选择、主行动和关键状态。

**The No Clone Green Rule.** 禁止把 IM 默认做成微信式绿色列表；绿色只允许作为小面积在线状态点。

## 3. Typography

**Display Font:** system-ui with platform sans fallback
**Body Font:** system-ui with platform sans fallback
**Label/Mono Font:** system-ui with platform sans fallback

**Character:** 单一系统字体保证移动端性能和可读性。层级通过字重、尺寸和密度控制，不通过夸张 display 字体制造陌生感。

### Hierarchy
- **Display** (800, 28px, 1.12): 页面总览、功能地图标题、重要统计。
- **Headline** (800, 22px, 1.18): 局部页面标题和详情页首屏。
- **Title** (800, 17px, 1.24): 列表项、入口模块、会话标题。
- **Body** (400, 14px, 1.45): 摘要、说明、消息正文；长文本保持 65-75ch 以内。
- **Label** (700, 12px, 1.2): 徽标、时间、状态、辅助动作。

### Named Rules

**The Dense Clarity Rule.** 产品 UI 不使用流体大标题；固定字号保证聊天、联系人和设置页面在移动端保持稳定密度。

## 4. Elevation

系统默认扁平，用色块、边界、分隔线和轻微 tonal layer 表达层级。阴影只用于悬浮层、底部面板和弹窗，普通卡片不同时使用大阴影和 1px 边框。

### Shadow Vocabulary
- **Panel Lift** (`0 8px 18px rgba(16, 24, 32, 0.08)`): 仅用于浮层、快捷面板和需要脱离内容流的控件。

### Named Rules

**The Flat First Rule.** 列表、卡片和输入框静止时用边界和底色表达，不用宽软阴影装饰。

## 5. Components

### Buttons
- **Shape:** 轻微圆角矩形 (8px)，避免过度圆润。
- **Primary:** Signal Teal 背景、白字、紧凑内边距。
- **Hover / Focus:** 边界或高对比焦点环，动效 150-200ms。
- **Secondary / Ghost:** 白底或透明底，使用 Line 边界和 Ink 文本。

### Chips
- **Style:** 浅色底 + 深色文本，使用 pill 形状承载状态。
- **State:** 已选筛选使用 Signal Soft；警告和审核使用 Amber Soft；失败使用 Pulse Soft。

### Cards / Containers
- **Corner Style:** 8px 圆角。
- **Background:** Surface 为默认，Fog 为分区或二级容器。
- **Shadow Strategy:** 默认无阴影，必要时只使用 Panel Lift。
- **Border:** 1px Line，禁止粗侧边条。
- **Internal Padding:** 12-16px。

### Inputs / Fields
- **Style:** Surface 背景、Line 边界、8px 圆角。
- **Focus:** Signal Teal 2px 边界或等效焦点环。
- **Error / Disabled:** Pulse Coral 文案 + 语义图标；禁用态降低对比但保持可读。

### Navigation
- **Style, typography, default/hover/active states, mobile treatment.** 底部导航使用熟悉 Material 结构，当前项用 Signal Soft 背景和 Signal Teal 图标文字。顶部栏保持简洁，连接状态和快捷入口作为可扫描工具。

### Signal Rail

会话列表、功能地图和验收状态使用轻量轨道：头像或图标作为节点，时间、未读、徽标作为信号，不使用装饰性时间线。

## 6. Do's and Don'ts

### Do:
- **Do** 保持文本对比度达到 WCAG AA，次级说明也不能过浅。
- **Do** 用文字、图标和位置同时表达关键状态。
- **Do** 让默认数据覆盖正常、空、失败、审核、锁定、权限不足。
- **Do** 保持卡片 8px 圆角，输入和按钮使用同一形状语言。
- **Do** 让 Signal Teal 稀缺，主要用于当前状态和主操作。

### Don't:
- **Don't** 做微信式绿色列表克隆。
- **Don't** 做深色霓虹 IM 控制台。
- **Don't** 做一屏一堆圆角卡片的 AI SaaS 模板。
- **Don't** 使用渐变文字、玻璃拟态、巨大阴影或装饰性动效。
- **Don't** 用超过 1px 的侧边色条作为卡片强调。
- **Don't** 只展示正常态，忽略空状态、失败状态、审核状态和权限不足状态。
