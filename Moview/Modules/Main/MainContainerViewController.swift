//
//  MainContainerViewController.swift
//  Moview
//
//  Created by Shubham Ojha on 15/05/20.
//  Copyright © 2020 Shubham. All rights reserved.
//

import SidebarOverlay

class MainContainerViewController: SOContainerViewController {
    
    var tabBarVC : AnimatedTabBarViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarVC = AnimatedTabBarViewController(nibName: nil, bundle: nil)
        tabBarVC?.isBottomLineShow = true
        tabBarVC?.bottomLineColor = .white
        tabBarVC?.tabBar.backgroundColor = UIColor(named: "AppColor")
        tabBarVC?.tabBar.tintColor = .white
        
        self.menuSide = .left
        self.topViewController  = tabBarVC
        self.sideViewController = UIStoryboard(name: Storyboards.shared.main, bundle: .main).instantiateViewController(withIdentifier: ViewControllers.shared.sidebar)
    }

}
