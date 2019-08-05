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
        
        APIClient.shared.GET(entity: NowPlayingResponse.self, urlRequest: MovieEndpoint.nowPlaying.urlRequest! , completionHandler: { (nowPlayingResponse) -> (Void) in
            
            DispatchQueue.main.async(execute: {
                self.hideProgress()
            })
            let fetchRequest = NSFetchRequest<Movie>.init(entityName: "Movie")
            fetchRequest.fetchLimit = 5
            fetchRequest.sortDescriptors?.append(NSSortDescriptor.init(key: "title", ascending: true))
            
            do {
                let fetchResults = try AppDelegate.backgroundContext.fetch(fetchRequest)
                self.nowPlayingMovies = fetchResults
                DispatchQueue.main.async(execute: {
                    self.collection_recent.reloadData()
                })
            }catch {
                print(error)
            }
            
        }) { (errCode, errMsg) -> (Void) in
            self.hideProgress()
            print("Error occured: \(errCode) \(errMsg)")
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
        let collectionCell = cell as? NowPlayingCollectionViewCell
        
        let posterPath = nowPlayingMovies[indexPath.row].poster_path != nil ? "https://image.tmdb.org/t/p/w500/" + nowPlayingMovies[indexPath.row].poster_path! : ""
        
        collectionCell?.imgV_poster.downloaded(from: URL.init(string: posterPath)!, contentMode: .top)
        collectionCell?.lbl_name.text = nowPlayingMovies[indexPath.row].original_title
    }

    
}

extension DashboardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: SCREEN_WIDTH)
    }
}
