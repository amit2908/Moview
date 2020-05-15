//
//  MainContainerViewController.swift
//  Moview
//
//  Created by Shubham Ojha on 15/05/20.
//  Copyright © 2020 Shubham. All rights reserved.
//

import SidebarOverlay

class MainContainerViewController: SOContainerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuSide = .left
        self.topViewController  = AnimatedTabBarViewController(nibName: nil, bundle: nil)
        self.sideViewController = UIStoryboard(name: Storyboards.shared.main, bundle: .main).instantiateViewController(withIdentifier: ViewControllers.shared.sidebar)
    }

}
