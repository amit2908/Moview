//
//  FavouriteMoviesViewController.swift
//  Moview
//
//  Created by Shubham Ojha on 15/05/20.
//  Copyright © 2020 Shubham. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class FavouriteMoviesViewController: UIViewController {
    @IBOutlet var barItem: RAMAnimatedTabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "My Favourites"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
