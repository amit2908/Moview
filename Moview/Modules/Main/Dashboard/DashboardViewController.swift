//
//  DashboardViewController.swift
//  Moview
//
//  Created by Empower on 22/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import CoreData

class DashboardViewController: UIViewController {
    @IBOutlet weak var navBar: CustomNavigationBar!
    @IBOutlet weak var collection_recent: UICollectionView!
    @IBOutlet weak var pageControl_recent: UIPageControl!
    @IBOutlet weak var collection_other: UICollectionView!
    
    
    
    var otherMovieDataSource : OtherMoviesDataSource?
    var recentMovieDataSource : RecentMoviesDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchNowPlayingMoviesDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupView()
    }
    
    
    private func setupView(){
        self.navBar.title = "Home"
        self.navBar.titleLabel.layer.zPosition = 10.0
        pageControl_recent.currentPage = 0
        pageControl_recent.numberOfPages = 5
        pageControl_recent.hidesForSinglePage = true
    }
    
    private func fetchNowPlayingMoviesDB(){
        
    }
    
    
    
    

}
