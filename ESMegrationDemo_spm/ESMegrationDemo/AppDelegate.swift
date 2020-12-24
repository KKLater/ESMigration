//
//  AppDelegate.swift
//  ESMegrationDemo
//
//  Created by 罗树新 on 2020/12/24.
//

import UIKit
import ESMigration

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

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

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

