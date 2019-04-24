//
//  Navigation.swift
//  Moview
//
//  Created by Empower on 22/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

struct Navigation {
    static let shared = Navigation()
    
    
    func navigateToDashboard(navigationController: UINavigationController){
        let dashboardVC = UIStoryboard(name: Storyboards.shared.main, bundle: .main).instantiateViewController(withIdentifier: ViewControllers.shared.dashboard)
        navigationController.viewControllers = [dashboardVC]
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.makeKeyAndVisible()
    }
}
