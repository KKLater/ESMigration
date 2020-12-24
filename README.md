# ESMigration

`Version：0.0.1`

ESMigration 库用于管理 App 版本升级或者 Build 版本升级时候的数据迁移，更新等操作。


## 安装

---

### SPM (推荐)

ESMigration 支持采用 Swift Package Manager 方式管理安装。

```swift
package.dependencies += [
    .package(url: "https://github.com/KKLater/ESMigration.git", from: "0.0.1"),
]
```

### Cocoapods

ESMigration 同样支持 pods 方式管理安装

```sh
    pod 'ESMigration', "~> 0.0.1"
```

## 使用

ESMigration 支持 App 版本的升级迁移和 Build 编译版本的升级迁移。App 版本的升级迁移使用 `Migration.App` ；Build 版本的升级迁移使用 `Migration.Build`。

**逐级升级迁移**
当前 migration 版本号 低于 App 版本号 并且，migration 版本号高于已记录之前的 migration 版本号时，执行对应操作。

```Swift

Migration.App.migration(to: "1.1.0") {
    print("Do migration App to 1.1.0")
}

```

**升级更新**
当前 App 版本号与已记录版本号不一致时，执行对应更新操作。版本号不存在大小对比，仅做 `==` 对比。即只需要当前版本号低于已记录版本号，可以完成降级支持。


```Swift
Migration.App.update {
    print("Do update App to 2.2.0")
}
```

**还原记录**
reset 方法，还原已记录迁移版本号和已记录升级版本号。仅做记录版本号清理，不会对已执行操作还原。

```Swift

/// 将迁移记录版本清空，将更新记录版本清空
Migration.App.reset()

/// 将迁移记录置为 1.1.0，将更新记录版本清空
Migration.App.reset(to: "1.1.0")
```

**查询记录版本号**
`lastMigrationVersion` 对应最后一次迁移版本号；
`lastUpdateVersion` 对应最后一次 `update` 记录版本号。

```Swift
Migration.App.lastMigrationVersion
```

## 其他

ESMegration 支持的版本号需要满足同一规则。例如，之前的版本号为 `1.0.0`，之后的版本号规则需保持一致 `2.0.2`或 `2.0`。不可以修改为  `v2.0`、`version2.0` 等。
版本号比较采用 `Swift.String` 的 `>`、`<`、`>=`、`<=`、`==` 比较。
`Action Block` 在 Migration 执行的线程执行。
