//
//  AppDelegate.swift
//  NotesApp
//
//  Created by John Diczhazy on 12/10/17.
//  Copyright © 2017 JohnDiczhazy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var plistPathInDocument:String = String()
    
    
    func preparePlistForUse(){
        // 1
        let rootPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, .userDomainMask, true)[0]
        // 2
        plistPathInDocument = rootPath + "/notes.plist"
        if !FileManager.default.fileExists(atPath: plistPathInDocument){
            let plistPathInBundle = Bundle.main.path(forResource: "notes", ofType: "plist") as String!
            // 3
            do {
                try FileManager.default.copyItem(atPath: plistPathInBundle!, toPath: plistPathInDocument)
            }catch{
                print("Error occurred while copying file to document \(error)")
            }
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Prepare the plist for writing mode, move it from the main bundle to the documents directory
        self.preparePlistForUse()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        // Prepare the plist for writing mode, move it from the main bundle to the documents directory
        self.preparePlistForUse()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

