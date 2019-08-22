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
        otherMovieDataSource = OtherMoviesDataSource(movies: nowPlayingMovies ,sections: sections)
        self.collection_other.dataSource = otherMovieDataSource
        self.collection_other.delegate = otherMovieDataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupView()
        self.fetchPlayingNowMovies()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func setupView(){
        self.navBar.titleLabel.text = "Home"
        pageControl_recent.currentPage = 0
        pageControl_recent.numberOfPages = 5
        pageControl_recent.hidesForSinglePage = true
    }
    
    private func fetchPlayingNowMovies(){
        self.showProgress(status: "Please wait...")
        
        var urlRequest = MovieEndpoint.nowPlaying.urlRequest!
        urlRequest.timeoutInterval = 2000
        APIClient.shared.GET(entity: NowPlayingResponse.self, urlRequest: urlRequest, completionHandler: { (nowPlayingResponse) -> (Void) in
            
            DispatchQueue.main.async(execute: {
                self.hideProgress()
            })
            let fetchRequest = NSFetchRequest<Movie>.init(entityName: "Movie")
            fetchRequest.fetchLimit = 3
//            fetchRequest.resultType = .dictionaryResultType
//            let expressionDescription = NSExpressionDescription()
//            expressionDescription.name = "count"
//            expressionDescription.expression = NSExpression(forFunction: "count:", arguments: [NSExpression(forKeyPath: "title")])
//            
//            fetchRequest.propertiesToFetch = ["title", expressionDescription];
//            fetchRequest.sortDescriptors?.append(NSSortDescriptor.init(key: "title", ascending: true))
            
            do {
                let fetchResults = try DataLayer.backgroundContext.fetch(fetchRequest)
                self.nowPlayingMovies = fetchResults
                self.otherMovieDataSource = OtherMoviesDataSource(movies: self.nowPlayingMovies ,sections: self.sections)
                DispatchQueue.main.async(execute: {
                    self.collection_other.delegate = self.otherMovieDataSource
                    self.collection_other.dataSource = self.otherMovieDataSource
                    self.collection_recent.reloadData()
                    self.collection_other.reloadData()
                })
            }catch {
                print(error)
            }
            
        }) { (errCode, errMsg) -> (Void) in
            self.hideProgress()
            print("Error occured: \(errCode) \(errMsg)")
        }
    }
    
    @objc private func setAsFavourite(sender: UIButton) {
        guard let cell = self.collection_recent.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as? NowPlayingCollectionViewCell else { return }
        cell.btn_favourite.setImage(UIImage.init(named: "favourite-selected"), for: .normal)
    }

}
extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentCellIdentifier", for: indexPath)
        guard  let nowPlayingCell = cell as? NowPlayingCollectionViewCell else {
            let newCell = NowPlayingCollectionViewCell.init()
            return newCell
        }
        nowPlayingCell.btn_favourite.tag = indexPath.row
        nowPlayingCell.btn_favourite.addTarget(self, action: #selector(self.setAsFavourite(sender:)), for: .touchUpInside);
        nowPlayingCell.backgroundColor = UIColor.init(red: CGFloat(indexPath.row/5), green: CGFloat(indexPath.row/5), blue: CGFloat(indexPath.row/5), alpha: 1)
        return nowPlayingCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl_recent.currentPage = indexPath.row
        let collectionCell = cell as? NowPlayingCollectionViewCell
        
        let posterPath = nowPlayingMovies[indexPath.row].poster_path != nil ? "https://image.tmdb.org/t/p/w500/" + nowPlayingMovies[indexPath.row].poster_path! : ""
        
        collectionCell?.imgV_poster.downloaded(from: URL.init(string: posterPath) ?? URL.init(fileURLWithPath: "picture.png", isDirectory: false), contentMode: .top)
        collectionCell?.lbl_name.text = nowPlayingMovies[indexPath.row].original_title
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Storyboards.shared.main, bundle: .main)
        let movieDetailVC = storyboard.instantiateViewController(withIdentifier: ViewControllers.shared.movieDetail) as? MovieDetailViewController
        movieDetailVC?.movieId = Int(self.nowPlayingMovies[indexPath.row].id)
        self.navigationController?.pushViewController(movieDetailVC!, animated: true)
    }
    
}

extension DashboardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 300)
    }
}
