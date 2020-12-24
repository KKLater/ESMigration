//
//  InterfaceController.swift
//  ESMigrationDemo_wtchos WatchKit Extension
//
//  Created by 罗树新 on 2020/12/24.
//

import WatchKit
import Foundation
import ESMigration


class InterfaceController: WKInterfaceController {

    
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
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        /// 修改 demo 的App 版本号和build版本号，看打印输出
        /// migration App version
        migrationApp()
        
        /// migration Build Version
        migrationBuild()
        
        /// 还原
//        reset()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}
