# 搭个话 IM

搭个话是一个 Flutter IM 客户端框架，包名 `blinblin.com`，当前重点覆盖 Android 和 Web 自动化打包。项目已根据功能地图整理出消息、联系人、我的、聊天、群管理、朋友圈、钱包、商品订单、表情、设置、全局公告、版本更新、通知跳转和运营配置等演示入口。

## 设计方向

- 产品定位见 `PRODUCT.md`
- 视觉系统见 `DESIGN.md`
- 核心视觉是 “Signal Loom / 对话信号流”
- 主界面包含消息会话、验收进度、状态案例和架构统计
- 默认数据覆盖正常、空、失败、审核、锁定和权限不足等验收状态

## 本地命令

当前设备如果没有 Flutter，不需要本地运行。具备 Flutter 环境时可执行：

```sh
flutter pub get
flutter analyze
flutter test
flutter build apk --release
flutter build web --release
```

也可以使用脚本：

```sh
sh scripts/build_android_web.sh
```

## GitHub 自动打包

已配置 `.github/workflows/build-android-web.yml`：

- push 到 `main` 时自动运行
- pull request 到 `main` 时自动运行
- 支持手动 `workflow_dispatch`
- 先执行 `flutter analyze` 和 `flutter test`
- 生成 Android release APK
- 生成 Web release 目录
- 上传 GitHub Actions artifacts

产物名称：

- `daggehua-android-apk`
- `daggehua-web-release`

## 一键推送

仓库 remote 配置完成后，可直接执行：

```sh
sh scripts/push_github.sh "chore: update project"
```

脚本会自动 `git add -A`、按消息提交，并推送当前分支到 `origin`。

## 关键目录

- `lib/` Flutter 客户端代码
- `lib/src/data/demo_data.dart` 默认演示数据
- `lib/src/ui/im_app.dart` 主界面框架
- `test/` Widget 测试
- `.github/workflows/` GitHub Actions 自动打包
- `.impeccable/` 设计工具配置
