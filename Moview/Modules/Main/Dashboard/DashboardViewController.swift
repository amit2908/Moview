//
//  DashboardViewController.swift
//  Moview
//
//  Created by Empower on 22/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

struct OtherMoviesCollectionViewModel {
    var dataSources : [MovieCollectionDataSource]
    var sections    : [String]
}

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var navBar: CustomNavigationBar!
    @IBOutlet weak var collection_recent: UICollectionView!
    @IBOutlet weak var pageControl_recent: UIPageControl!
    @IBOutlet weak var collection_other: UICollectionView!
    @IBOutlet var barItem: RAMAnimatedTabBarItem!
    
    var otherMovieDataSource : OtherMoviesDataSource?
    var recentMovieDataSource : RecentMoviesDataSource?
    
    var recentMoviesPresenter : IRecentMoviesPresenter?
    var otherMoviesPresenter  : IOtherMoviesPresenter?
    
    let configurator: DashboardConfigurator = DashboardConfigurator()
    
    private let dispatchGroup = DispatchGroup.init()
    
    private var otherMoviesViewModel : OtherMoviesCollectionViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configurator.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadData()
        dispatchGroup.notify(queue: .main) {
            self.otherMovieDataSource = OtherMoviesDataSource.init(otherMoviesViewModel: self.otherMoviesViewModel!, vc: self)
            self.collection_other.dataSource = self.otherMovieDataSource
            self.collection_other.delegate = self.otherMovieDataSource
            
            self.collection_recent.reloadData()
            self.collection_other.reloadData()
        }
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
        
        otherMoviesViewModel = OtherMoviesCollectionViewModel(dataSources: [], sections: [])
        
        dispatchGroup.enter()
        self.recentMoviesPresenter?.loadNowPlayingMovies { [unowned self] (movies) -> (Void) in
            
                self.recentMovieDataSource = RecentMoviesDataSource.init(nowPlayingMovies: movies, collectionView: self.collection_recent)
                
                self.collection_recent.dataSource = self.recentMovieDataSource
                self.collection_recent.delegate = self.recentMovieDataSource
               
            self.dispatchGroup.leave()
        }

        dispatchGroup.enter()
        self.otherMoviesPresenter?.loadTopRatedMovies(page: 1) { [unowned self] (movies) in
            self.otherMoviesViewModel?.sections.append("Top Rated")
            self.otherMoviesViewModel?.dataSources.append(MovieCollectionDataSource(movies: movies))
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        self.otherMoviesPresenter?.loadLatestMovie() {  [unowned self] (movies) in
            self.otherMoviesViewModel?.sections.append("Latest Movies")
            self.otherMoviesViewModel?.dataSources.append(MovieCollectionDataSource(movies: movies))
            self.dispatchGroup.leave()
        }
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
        
        var movies = [IMovie]()
        if let mov = self.otherMoviesPresenter?.movieDataSources[button.tag].movies {
            movies = mov
        }
        
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
