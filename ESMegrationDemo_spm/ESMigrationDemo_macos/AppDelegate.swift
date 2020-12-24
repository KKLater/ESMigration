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

