//
//  AppDelegate.swift
//  ESMigrationDemo_macos
//
//  Created by 罗树新 on 2020/12/24.
//

import Cocoa
import ESMigration

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func migrationApp() {
        Migration.App.migration(to: "1.1.0") {
            print("AppDelegate: Do migration App to 1.1.0")
        }
        
        Migration.App.migration(to: "2.2.0") {
            print("AppDelegate: Do migration App to 2.2.0")
        }
        
        Migration.App.update {
            print("AppDelegate: Do update App to 2.2.0")
        }
    }
    
    func migrationBuild() {
        Migration.Build.migration(to: "1.1.0") {
            print("AppDelegate: Do migration build to 1.1.0")
        }
        
        Migration.Build.migration(to: "2.2.0") {
            print("AppDelegate: Do migration build to 2.2.0")
        }
        
        Migration.Build.update {
            print("AppDelegate: Do update build to 2.2.0")

        }
    }
    
    func reset() {
        Migration.App.reset()
        Migration.Build.reset()

        // 重置到 最近一期迁移版本，1.1.0。即之后的 migration 会把 大于 1.1.0 版本且小于等于当前 App build 版本的执行一次
        // 重置操作，同步清理掉 update 版本操作记录
        // Migration.Build.reset(to: "1.1.0")
        // Migration.App.reset(to: "1.1.0")
    }
    


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        /// 修改 demo 的App 版本号和build版本号，看打印输出
        /// migration App version
        migrationApp()
        
        /// migration Build Version
        migrationBuild()
        
        /// 还原
//        reset()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

