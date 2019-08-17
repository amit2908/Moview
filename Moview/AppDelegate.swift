//
//  AppDelegate.swift
//  Moview
//
//  Created by Empower on 22/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import CoreData
import Toast_Swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /*Service.shared.getRequestToken(completion: { (token) in
         UserDefaults.standard.set(token, forKey: Keys.shared.REQUEST_TOKEN)
         }) { (error, message) in
         //            ApplicationManager.sharedInstance.showAlertPicker(vc: self, title: "alert", buttonTitle: "Ok".localized(), message: message, handler: {})
         }*/
        
        self.observeInternetConnection()
        
        return true
    }
    
    func observeInternetConnection() {
        NetworkManager.shared.startNotifier()
        NotificationCenter.default.addObserver(self, selector: #selector(self.checkInternetConnection), name: Notification.Name.reachabilityChanged, object: nil)
    }
    
    @objc func checkInternetConnection(note: Notification){
        NetworkManager.shared.isReachable(completionHandler: { (connected, connectionType) in
            if connected {
                if connectionType == .cellular {
                    DispatchQueue.main.async {
                        self.window?.makeToast("Switched to Cellular network.")
                        self.checkInternetSpeed()
                    }
                }else if connectionType == .wifi {
                    DispatchQueue.main.async {
                        self.window?.makeToast("Switched to Wifi.")
                        self.checkInternetSpeed()
                    }
                }else if connectionType == .none {
                    DispatchQueue.main.async {
                        self.window?.makeToast("Network not available. Please check your network connection.")
                    }
                }
            }else {
                DispatchQueue.main.async {
                    self.window?.makeToast("Network not available. Please check your network connection.")
                }
            }
        })
    }
    
    func checkInternetSpeed(){
        NetworkManager.shared.checkInternetSpeed { (speed) in
            DispatchQueue.main.async {
                self.window?.makeToast("Internet speed is \(speed.rawValue)")
            }
        }
    }
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static var viewContext = {
        return AppDelegate.persistentContainer.viewContext
    }()
    
    static var backgroundContext = {
        return AppDelegate.persistentContainer.newBackgroundContext()
    }()
    
    // MARK: - Core Data Saving support
    
    static func saveContext (context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        AppDelegate.saveContext(context: AppDelegate.viewContext)
    }
    
    
}

