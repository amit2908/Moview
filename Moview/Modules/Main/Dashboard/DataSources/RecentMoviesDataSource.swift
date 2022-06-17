//
//  RecentMoviesDataSource.swift
//  Moview
//
//  Created by Shubham Ojha on 22/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import CoreData

protocol DisplayDelegate {
    func didDisplayCell(atIndex index: Int)
}

class RecentMoviesDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let nowPlayingMovies: [IMovie]
    let collectionView : UICollectionView
    var displayDelegate : DisplayDelegate?
    
    init(nowPlayingMovies: [IMovie], collectionView: UICollectionView) {
        self.nowPlayingMovies = nowPlayingMovies
        self.collectionView = collectionView
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentCellIdentifier", for: indexPath)
        guard  let nowPlayingCell = cell as? NowPlayingCollectionViewCell else {
            let newCell = NowPlayingCollectionViewCell.init()
            return newCell
        }
        nowPlayingCell.configure(withData: nowPlayingMovies[indexPath.item])
        nowPlayingCell.btn_favourite.tag = indexPath.item
        nowPlayingCell.btn_favourite.addTarget(self, action: #selector(setAsFavourite(sender:)), for: .touchUpInside);
        
        return nowPlayingCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        self.pageControl_recent.currentPage = indexPath.row
        let collectionCell = cell as? NowPlayingCollectionViewCell
        
        let imageLink = nowPlayingMovies[indexPath.row].imageLink
        let posterPath = K.Server.imageBaseURL + "/\(ImageSize.xLarge)" + imageLink
        
        collectionCell?.imgV_poster.sd_setImage(with: URL.init(string: posterPath), completed: nil)
        collectionCell?.lbl_name.text = nowPlayingMovies[indexPath.row].title
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.displayDelegate?.didDisplayCell(atIndex: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Storyboards.shared.main, bundle: .main)
        let movieDetailVC = storyboard.instantiateViewController(withIdentifier: ViewControllers.shared.movieDetail) as? MovieDetailViewController
        movieDetailVC?.movieId = Int32.init(truncatingIfNeeded: self.nowPlayingMovies[indexPath.row].id)
    }
    
    @objc func setAsFavourite(sender: UIButton) {
        guard let cell = self.collectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as? NowPlayingCollectionViewCell else { return }
        cell.btn_favourite.setImage(UIImage.init(named: "favourite-selected"), for: .normal)
    }
    
}

extension RecentMoviesDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 300)
    }
}

