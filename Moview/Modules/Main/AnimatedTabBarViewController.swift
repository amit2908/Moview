//
//  AnimatedTabBarViewController.swift
//  Moview
//
//  Created by Shubham Ojha on 15/05/20.
//  Copyright © 2020 Shubham. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class AnimatedTabBarViewController: RAMAnimatedTabBarController{
    
//    override var tabBar: UITabBar {
//        return AppTabBar()
//    }
//    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let dashboardVC = UIStoryboard(name: Storyboards.shared.main, bundle: .main).instantiateViewController(withIdentifier: ViewControllers.shared.dashboard)
        
        let favouritesVC = UIStoryboard(name: Storyboards.shared.main, bundle: .main).instantiateViewController(withIdentifier: ViewControllers.shared.favourites)
        
        self.viewControllers = [dashboardVC, favouritesVC]
    
    }
    

}

//class AppTabBar: UITabBar {
//    override func draw(_ rect: CGRect) {
//        self.layer.cornerRadius = 10.0
//        self.layer.masksToBounds = true
//    }
//}
