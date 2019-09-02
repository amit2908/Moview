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
    
    var nowPlayingMovies = [Movie]()
    var otherMovies = [Movie]()
    
    var sections = ["Top Rated", "Latest", "Favourites", "Action", "Romantic"]
    var otherMovieDataSource : OtherMoviesDataSource?
    var recentMovieDataSource : RecentMoviesDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupView()
        self.fetchNowPlayingMoviesFromLocalDB()
        self.fetchPlayingNowMovies()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func setupView(){
        self.navBar.title = "Home"
        self.navBar.titleLabel.layer.zPosition = 10.0
        pageControl_recent.currentPage = 0
        pageControl_recent.numberOfPages = 5
        pageControl_recent.hidesForSinglePage = true
    }
    
    private func fetchNowPlayingMoviesFromLocalDB(){
        let fetchRequest = NSFetchRequest<Movie>.init(entityName: "Movie")
        fetchRequest.fetchLimit = 3
        do {
            let fetchResults = try DataLayer.backgroundContext.fetch(fetchRequest)
            self.nowPlayingMovies = fetchResults
            self.otherMovieDataSource = OtherMoviesDataSource(movies: self.nowPlayingMovies ,sections: self.sections, vc: self)
            self.recentMovieDataSource = RecentMoviesDataSource(movies: self.nowPlayingMovies, collectionView: self.collection_recent)
            DispatchQueue.main.async(execute: {
                self.collection_other.delegate = self.otherMovieDataSource
                self.collection_other.dataSource = self.otherMovieDataSource
                self.collection_recent.delegate = self.recentMovieDataSource
                self.collection_recent.dataSource = self.recentMovieDataSource
                self.collection_recent.reloadData()
                self.collection_other.reloadData()
            })
        }catch {
            print(error)
        }
        
    }
    
    private func fetchPlayingNowMovies(){
        
        var urlRequest = MovieEndpoint.nowPlaying.urlRequest!
        urlRequest.timeoutInterval = 2000
        APIClient.shared.GET(entity: NowPlayingResponse.self, urlRequest: urlRequest, completionHandler: { (nowPlayingResponse) -> (Void) in
            
            self.fetchNowPlayingMoviesFromLocalDB()
            
        }) { (errCode, errMsg) -> (Void) in
            self.hideProgress()
            print("Error occured: \(errCode) \(errMsg)")
        }
    }
    
    

}
