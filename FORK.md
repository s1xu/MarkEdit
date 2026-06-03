# macOS 14 Fork

这个 fork 用于维护一份面向 macOS 14 的 MarkEdit 版本。目标是保留 upstream MarkEdit 的主要体验，同时在 `macos14` 分支上选择性 backport 适用于 macOS 14 的修复。

## 分支

- `main`: 跟踪 upstream 最新代码，不保证兼容 macOS 14。
- `macos14`: macOS 14 构建和发布使用的稳定维护分支。
- `feature/*` 和 `backport/*`: 从 `macos14` 创建，用于 fork-only 改动或选择性 backport upstream 修复。

## 兼容性

- 基础版本: MarkEdit 1.26.1
- Deployment target: macOS 14.0+
- Release tags: `macos14-v*`，例如 `macos14-v1.26.1-1`

## 已包含改动

- 修复 MarkEdit 1.26.1 在 macOS 14 上可能出现的保存、关闭窗口后未响应问题。
- Backport upstream PR [#1446](https://github.com/MarkEdit-app/MarkEdit/pull/1446)，修复 incorrect selection change handling 和 dirty flag updates。
- 保留 macOS 14 所需的 Xcode 构建兼容性调整。
- 为 `macos14` 分支增加 GitHub Actions 构建和发布流程。

## Fork-only 配置

### 关闭最后一个编辑窗口后退出应用

默认情况下，MarkEdit 会在关闭最后一个编辑窗口后继续保持应用运行。这个 fork 根据 upstream issue [#1392](https://github.com/MarkEdit-app/MarkEdit/issues/1392) 增加了一个可选配置，用于在关闭最后一个编辑窗口后自动退出应用：

```json
{
  "general.quitsAfterLastWindowClosed": true
}
```

配置文件位置：

```text
~/Library/Containers/app.cyan.markedit/Data/Documents/settings.json
```

默认值为 `false`。修改 `settings.json` 后需要重启 MarkEdit 生效。

## 发布流程

`macos14` 分支的发布通过 tag 触发：

```bash
git tag macos14-v1.26.1-1
git push origin macos14-v1.26.1-1
```

GitHub Actions 会构建 Release 版本的 `MarkEdit.app`，打包为 zip，并创建 GitHub Release。

## 维护原则

- 只 backport 这个 fork 明确需要的 upstream bug fix。
- 不把 upstream 最新 `main` 直接合并到 `macos14`。
- fork-only 功能尽量通过显式配置控制，默认行为保持 upstream 兼容。
- 每次 backport upstream 修复时，单独创建 `backport/*` 分支并通过 pull request 合并回 `macos14`。

---

# macOS 14 Fork

This fork maintains a macOS 14-compatible build of MarkEdit. The goal is to keep the main MarkEdit experience intact while selectively backporting fixes that are useful for macOS 14 on the `macos14` branch.

## Branches

- `main`: Tracks the latest upstream code. macOS 14 compatibility is not guaranteed.
- `macos14`: Stable maintenance branch for macOS 14 builds and releases.
- `feature/*` and `backport/*`: Created from `macos14` for fork-only changes or selected upstream backports.

## Compatibility

- Base version: MarkEdit 1.26.1
- Deployment target: macOS 14.0+
- Release tags: `macos14-v*`, for example `macos14-v1.26.1-1`

## Included Changes

- Fixes the possible save and window-close hang seen with MarkEdit 1.26.1 on macOS 14.
- Backports upstream PR [#1446](https://github.com/MarkEdit-app/MarkEdit/pull/1446), which fixes incorrect selection change handling and dirty flag updates.
- Keeps the Xcode build compatibility changes needed for macOS 14.
- Adds GitHub Actions build and release workflows for the `macos14` branch.

## Fork-only Options

### Quit after closing the last editor window

By default, MarkEdit keeps running after the last editor window is closed. This fork adds an optional setting based on upstream issue [#1392](https://github.com/MarkEdit-app/MarkEdit/issues/1392) to quit the app automatically after the last editor window is closed:

```json
{
  "general.quitsAfterLastWindowClosed": true
}
```

Settings file location:

```text
~/Library/Containers/app.cyan.markedit/Data/Documents/settings.json
```

The default value is `false`. Restart MarkEdit after changing `settings.json`.

## Release Flow

Releases for the `macos14` branch are triggered by tags:

```bash
git tag macos14-v1.26.1-1
git push origin macos14-v1.26.1-1
```

GitHub Actions builds the Release version of `MarkEdit.app`, packages it as a zip archive, and creates a GitHub Release.

## Maintenance Policy

- Only backport upstream bug fixes that are clearly needed for this fork.
- Do not merge the latest upstream `main` directly into `macos14`.
- Keep fork-only features behind explicit settings when possible, with upstream-compatible defaults.
- Create a dedicated `backport/*` branch for each upstream fix and merge it back into `macos14` through a pull request.
