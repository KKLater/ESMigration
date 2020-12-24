
import Foundation

/// Migration 是用于版本升级时，做数据迁移或更新数据操作使用
/// Migration 涉及到的 version 均采用字符串 `<`、`>`、`<=`、`>=`、`==` 方案比较
/// Migration 使用版本需要版本一致性，即沿用统一规范，之前是 `1.1.0` 纯数字方式，之后 `1.2.0` 数据迁移或更新时，仍需要采用该规范，不可更换 `v1.2.0` 或 `version1.2.0`
///
///     `App` 正式版本升级到`1.2.0`，数据迁移：
///         Migration.App.migration(to: "1.2.0") {
///             // 数据迁移操作
///         }
///
///     `App` 正式版本升级到 `1.2.0`，更新操作：
///         Migration.App.update {
///             // 更新操作
///         }
///
///     `App` build 版本号升级到 `1.2.0`，数据迁移：
///         Migration.Build.migration(to: "1.2.0") {
///             // 数据迁移操作
///         }
///
///     `App` build 版本号升级到 `1.2.0`，更新操作：
///         Migration.Build.update {
///             // 更新操作
///         }
public struct Migration {
    public struct App {
        
        private struct UserDefaultKey {
            static let lastUpdateVersion = "com.es.migration.last.app.update.version.key"
            static let lastMigrationVersion = "com.es.migration.last.app.migration.version.key"
        }
        
        /// App 版本升级，迁移
        /// - Parameters:
        ///   - version: 迁移操作执行版本
        ///   - action: 迁移操作
        ///
        /// 当 没有  `lastMigrationVersion` 并且` version <= appVersion` 时，会执行迁移操作
        /// 当 `version > lastMigrationVersion` 并且 `version <= appVersion` 时，会执行迁移操作
        /// 执行迁移操作结束后，会将 `version` 存储为 `lastMigrationVersion`
        public static func migration(to version: String, action: () -> ()) {
            // version > lastMigrationVersion && version <= appVersion

            var compareMigrationVersionResult = false

            if let lastMigrationVersion = lastMigrationVersion {
                if version > lastMigrationVersion {
                    /// 之前保有升级记录，并且本地升级version，大于记录version；本次可继续比较升级
                    compareMigrationVersionResult = true
                }
            } else {
                /// 之前没有过升级记录；本次可继续比较升级
                compareMigrationVersionResult = true
            }
            
            if compareMigrationVersionResult == true {
                
                /// 升级版本与当前app版本一致或高于当前版本
                if version <= appVersion {
                    action()
                    #if DEBUG
                    print("ESMigration: Running migration for version: \(version)")
                    #endif
                    lastMigrationVersion = version
                }
            }
        }
        
        /// App 升级更新
        /// - Parameter action: 升级操作
        ///
        /// 当 `lastUpdateVersion` 与 当前版本 `appVersion` 不一致时，执行更新操作
        /// 更新操作执行后，会将 `appVersion` 存储为 `lastUpdateVersion`
        public static func update(_ action: () -> ()) {
            if lastUpdateVersion != appVersion {
                action()
                #if DEBUG
                print("ESMigration: Running update Block for version: \(appVersion)")
                #endif
                lastUpdateVersion = appVersion
            }
        }
        
        /// 重置迁移版本记录和更新版本记录
        /// - Parameters:
        ///   - migrationVersion: 重置最近迁移版本号
        ///
        /// 仅仅做版本记录清理，实际迁移或升级操作未能复原
        /// 如需重新做迁移或升级操作复原，仍需要重置后，重新 `migration` 或 `update`
        public static func reset(to migrationVersion: String? = nil) {
            lastMigrationVersion = migrationVersion
            lastUpdateVersion = nil
            #if DEBUG
            if let migrationVersion = migrationVersion {
                print("ESMigration: Running reset build: \(appVersion), migration version: \(migrationVersion)")
            } else {
                print("ESMigration: Running reset build: \(appVersion)")
            }
            #endif
        }
        
        /// 当前 `App` 版本号
        ///
        /// From `CFBundleShortVersionString`
        public static var appVersion: String {
            guard let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
                return ""
            }
            return version
        }
        
        /// 最近一次升级迁移版本记录
        public static fileprivate(set) var lastMigrationVersion: String? {
            get {
                let lastMigrationVersion = UserDefaults.standard.string(forKey: UserDefaultKey.lastMigrationVersion)
                return lastMigrationVersion
            }
            set {
                if lastMigrationVersion != newValue {
                    UserDefaults.standard.setValue(newValue, forKey: UserDefaultKey.lastMigrationVersion)
                    UserDefaults.standard.synchronize()
                }
            }
        }
        
        /// 最后一次升级更新版本记录
        public static fileprivate(set) var lastUpdateVersion: String? {
            get {
                let lastUpdateVersion = UserDefaults.standard.string(forKey: UserDefaultKey.lastUpdateVersion)
                return lastUpdateVersion
            }
            set {
                if lastUpdateVersion != newValue {
                    UserDefaults.standard.setValue(newValue, forKey: UserDefaultKey.lastUpdateVersion)
                    UserDefaults.standard.synchronize()
                }
            }
        }
    }
    
    public struct Build {
        
        private struct UserDefaultKey {
            static let lastUpdateVersion = "com.es.migration.last.build.update.version.key"
            static let lastMigrationVersion = "com.es.migration.last.build.migration.version.key"
        }
        
        /// build 版本升级迁移
        /// - Parameters:
        ///   - version: build 迁移操作执行版本号，可以使用 `1.1.0`，`不可使用 V1.1.0\Version1.1.0\v1.1.0\version1.1.0`
        ///   - action: 迁移操作
        ///
        /// 当 没有  `lastMigrationVersion` 并且` version <= appVersion` 时，会执行迁移操作
        /// 当 `version > lastMigrationVersion` 并且 `version <= appVersion` 时，会执行迁移操作
        /// 执行迁移操作结束后，会将 `version` 存储为 `lastMigrationVersion`
        public static func migration(to version: String, action: () -> ()) {
            
            // buildVersion > lastMigrationBuild && buildVersion <= appVersion

            var compareMigrationBuildResult = false
            
            if let lastMigrationVersion = lastMigrationVersion {
                if version > lastMigrationVersion {
                    /// 之前保有升级记录，并且本地升级version，大于记录version；本次可继续比较升级
                    compareMigrationBuildResult = true
                }
            } else {
                /// 之前没有过升级记录；本次可继续比较升级
                compareMigrationBuildResult = true
            }
            
            if compareMigrationBuildResult == true {
                
                /// 升级版本与当前app版本一致或高于当前版本
                if version <= appBuildVersion {
                    action()
                    #if DEBUG
                    print("ESMigration: Running migration for build: \(version)")
                    #endif
                    lastMigrationVersion = version
                }
            }
        }
        
        /// build 版本升级更新操作
        /// - Parameter action: 升级更新操作
        ///
        /// 当 `lastUpdateVersion` 与 当前版本 `appVersion` 不一致时，执行更新操作
        /// 更新操作执行后，会将 `appBuildVersion` 存储为 `lastUpdateVersion`
        public static func update(_ action: () -> ()) {
            if lastUpdateVersion != appBuildVersion {
                action()
                #if DEBUG
                print("ESMigration: Running update Block for build: \(appBuildVersion)")
                #endif
                lastUpdateVersion = appBuildVersion
            }
        }
        
        /// 重置 `build` 迁移和升级更新版本记录
        /// - Parameters:
        ///   - migrationVersion: 重置最近迁移版本号
        ///
        /// 仅仅做版本记录清理，实际迁移或升级操作未能复原
        /// 如需重新做迁移或升级操作复原，仍需要重置后，重新 `migration` 或 `update`
        public static func reset(to migrationVersion: String? = nil) {
            lastMigrationVersion = migrationVersion
            lastUpdateVersion = nil
            #if DEBUG
            if let migrationVersion = migrationVersion {
                print("ESMigration: Running reset build: \(appBuildVersion), migration version: \(migrationVersion)")
            } else {
                print("ESMigration: Running reset build: \(appBuildVersion)")
            }
            #endif
        }
                
        /// `App` 当前 `build` 版本号
        ///
        /// From `CFBundleVersion`
        public static var appBuildVersion: String {
            guard let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else {
                return ""
            }
            return version
        }
        
        /// 最近一次 `build`  迁移版本号
        public static fileprivate(set) var lastMigrationVersion: String? {
            get {
                let appBuild = UserDefaults.standard.string(forKey: UserDefaultKey.lastMigrationVersion)
                return appBuild
            }
            set {
                if lastMigrationVersion != newValue {
                    UserDefaults.standard.setValue(newValue, forKey: UserDefaultKey.lastMigrationVersion)
                    UserDefaults.standard.synchronize()
                }
            }
        }
        
        /// 最近一个 `build` 更新版本号
        public static fileprivate(set) var lastUpdateVersion: String? {
            get {
                let updateVersion = UserDefaults.standard.string(forKey: UserDefaultKey.lastUpdateVersion)
                return updateVersion
            }
            set {
                if lastUpdateVersion != newValue {
                    UserDefaults.standard.setValue(newValue, forKey: UserDefaultKey.lastUpdateVersion)
                    UserDefaults.standard.synchronize()
                }
            }
        }
    }
}
