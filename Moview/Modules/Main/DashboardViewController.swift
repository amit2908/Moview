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
    
    var nowPlayingMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupView()
        self.fetchPlayingNowMovies()
    }
    
    private func setupView(){
        self.navBar.title = "Home".localized()
        pageControl_recent.currentPage = 0
        pageControl_recent.numberOfPages = 5
        pageControl_recent.hidesForSinglePage = true
    }
    
    private func fetchPlayingNowMovies(){
        self.showProgress(status: "Please wait...")
        APIClient.shared.nowPlaying { (movies) in
            self.hideProgress()
            
            let fetchRequest = NSFetchRequest<Movie>.init(entityName: "Movie")
            fetchRequest.fetchLimit = 5
            fetchRequest.sortDescriptors[NSSortDescriptor.init(key: "title", ascending: true)]
            
            do {
                let fetchResults = try AppDelegate.backgroundContext.fetch(fetchRequest)
                for movie in fetchResults {
                    print(movie.original_title ?? "")
                }
            }catch {
                print(error)
            }
        }
    }

}
extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentCellIdentifier", for: indexPath)
        cell.backgroundColor = UIColor.init(red: CGFloat(indexPath.row/5), green: CGFloat(indexPath.row/5), blue: CGFloat(indexPath.row/5), alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl_recent.currentPage = indexPath.row
    }

    
}
