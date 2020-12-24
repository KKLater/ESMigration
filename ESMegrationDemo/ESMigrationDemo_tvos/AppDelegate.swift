//
//  AppDelegate.swift
//  ESMigrationDemo_tvos
//
//  Created by 罗树新 on 2020/12/24.
//

import UIKit
import ESMigration

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

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
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// 修改 demo 的App 版本号和build版本号，看打印输出
        /// migration App version
        migrationApp()
        
        /// migration Build Version
        migrationBuild()
        
        /// 还原
//        reset()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


}

