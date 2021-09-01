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
        
        
        self.observeInternetConnection()
        
        let animatedLaunchVC = AnimatedLaunchScreenViewController(nibName: nil, bundle: nil)
        
        let navigationController = UINavigationController(rootViewController: animatedLaunchVC)
        
        self.window?.rootViewController = navigationController
        
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
    
    
}

