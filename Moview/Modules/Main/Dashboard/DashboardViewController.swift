//
//  DashboardViewController.swift
//  Moview
//
//  Created by Empower on 22/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class DashboardViewController: UIViewController {
    @IBOutlet weak var navBar: CustomNavigationBar!
    @IBOutlet weak var collection_recent: UICollectionView!
    @IBOutlet weak var pageControl_recent: UIPageControl!
    @IBOutlet weak var collection_other: UICollectionView!
    @IBOutlet var barItem: RAMAnimatedTabBarItem!
    
    var otherMovieDataSource : OtherMoviesDataSource?
    var recentMovieDataSource : RecentMoviesDataSource?
    
    let recentMoviesPresenter : RecentMoviesCollectionPresenter
    let otherMoviesPresenter  : OtherMoviesCollectionPresenter
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let networkLayer     = NetworkLayer()
        let dataLayer        = DataLayer()
        let translationLayer = TranslationLayer()
        let modelLayer       = ModelLayer(networkLayer: networkLayer, dataLayer: dataLayer, translationLayer: translationLayer)
        self.recentMoviesPresenter       = RecentMoviesCollectionPresenter(modelLayer: modelLayer)
        self.otherMoviesPresenter        = OtherMoviesCollectionPresenter(modelLayer: modelLayer)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        let networkLayer     = NetworkLayer()
        let dataLayer        = DataLayer()
        let translationLayer = TranslationLayer()
        let modelLayer       = ModelLayer(networkLayer: networkLayer, dataLayer: dataLayer, translationLayer: translationLayer)
        self.recentMoviesPresenter       = RecentMoviesCollectionPresenter(modelLayer: modelLayer)
        self.otherMoviesPresenter        = OtherMoviesCollectionPresenter(modelLayer: modelLayer)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recentMovieDataSource = RecentMoviesDataSource(presenter: recentMoviesPresenter, collectionView: collection_recent)
        self.collection_recent.dataSource = recentMovieDataSource
        self.collection_recent.delegate = recentMovieDataSource
        
        otherMovieDataSource = OtherMoviesDataSource(presenter: otherMoviesPresenter, vc: self)
        self.collection_other.dataSource = otherMovieDataSource
        self.collection_other.delegate = otherMovieDataSource

        self.loadData()
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
        
        self.navBar.btn_right.setImage(UIImage(named: "refresh"), for: .normal)
        self.navBar.btn_right.addTarget(self, action: #selector(self.loadData), for: .touchUpInside)
        
        
        self.navBar.btn_left.isHidden = false
        self.navBar.btn_left.setImage(UIImage(named: "menu"), for: .normal)
        self.navBar.btn_left.addTarget(self, action: #selector(showSidebar), for: .touchDown)
        
    }
    
    
    @objc func loadData(){
        self.recentMoviesPresenter.loadNowPlayingMovies { [unowned self] (_) -> (Void) in
            DispatchQueue.main.async {
                self.collection_recent.performBatchUpdates({
                     self.collection_recent.reloadData()
//                    UIView.animate(withDuration: 1.5) {
//                        cell.frame.origin = CGPoint(x: cell.frame.origin.x + CGFloat(indexPath.item * 10) , y: cell.frame.origin.y)
//                    }
                }) { (success) in
                    
                }
               
            }
        }
        self.otherMoviesPresenter.loadUpcomingMovies(page: 1) { (_) -> (Void) in
            DispatchQueue.main.async {
                self.collection_other.reloadData()
            }
        }
        
        self.otherMoviesPresenter.loadTopRatedMovies(page: 1) { (_) -> (Void) in
            DispatchQueue.main.async {
                self.collection_other.reloadData()
            }
        }
        
//        self.otherMoviesPresenter.loadLatestMovie() { (_) -> (Void) in
//            DispatchQueue.main.async {
//                self.collection_other.reloadData()
//            }
//        }
    }
    
    
    //MARK: NAVBAR ACTIONS
    
    @objc func showSidebar() {
        if let container = self.so_containerViewController {
            container.isSideViewControllerPresented = true
        }
    }
    

}
//MARK: Actions
extension DashboardViewController {
    @objc func showMoreBtnClicked(button: UIButton) {
        
        var movies = [Movie]()
        movies = self.otherMoviesPresenter.movieDataSources[button.tag].movies
        
        Navigation.shared.navigateToMovieList(navigationController: self.navigationController!, movieTypes: MovieTypes(rawValue: button.tag), movies: movies)
    }

}

extension UICollectionViewCell {
    func startWiggling() {
        UIView.animate(withDuration: TimeInterval.infinity, delay: 0.0, options: .repeat, animations: {
            self.transform = CGAffineTransform(rotationAngle: 3.14/6)
        }, completion: { (_) in
            
        })
    }
    
    func stopWiggling() {
        self.layer.removeAllAnimations()
    }
}
