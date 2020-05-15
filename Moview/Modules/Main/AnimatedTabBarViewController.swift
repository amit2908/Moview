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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let dashboardVC = UIStoryboard(name: Storyboards.shared.main, bundle: .main).instantiateViewController(withIdentifier: ViewControllers.shared.dashboard)
        
        let favouritesVC = UIStoryboard(name: Storyboards.shared.main, bundle: .main).instantiateViewController(withIdentifier: ViewControllers.shared.favourites)
        
        self.viewControllers = [dashboardVC, favouritesVC]
    
    }
    

}
