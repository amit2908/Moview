//
//  RecentMoviesDataSource.swift
//  Moview
//
//  Created by Shubham Ojha on 22/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import CoreData

class RecentMoviesDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let presenter : DashboardPresenter
    let collectionView : UICollectionView
    
    init(presenter: DashboardPresenter, collectionView: UICollectionView) {
        self.presenter = presenter
        self.collectionView = collectionView
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.nowPlayingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentCellIdentifier", for: indexPath)
        guard  let nowPlayingCell = cell as? NowPlayingCollectionViewCell else {
            let newCell = NowPlayingCollectionViewCell.init()
            return newCell
        }
        nowPlayingCell.btn_favourite.tag = indexPath.row
        nowPlayingCell.btn_favourite.addTarget(self, action: #selector(setAsFavourite(sender:)), for: .touchUpInside);
        nowPlayingCell.backgroundColor = UIColor.init(red: CGFloat(indexPath.row/5), green: CGFloat(indexPath.row/5), blue: CGFloat(indexPath.row/5), alpha: 1)
        return nowPlayingCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        self.pageControl_recent.currentPage = indexPath.row
        let collectionCell = cell as? NowPlayingCollectionViewCell
        
        let posterPath = presenter.nowPlayingMovies[indexPath.row].poster_path != nil ? "https://image.tmdb.org/t/p/w500/" +    presenter.nowPlayingMovies[indexPath.row].poster_path! : ""
        
        collectionCell?.imgV_poster.downloaded(from: URL.init(string: posterPath) ?? URL.init(fileURLWithPath: "picture.png", isDirectory: false), contentMode: .top)
        collectionCell?.lbl_name.text = presenter.nowPlayingMovies[indexPath.row].original_title
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Storyboards.shared.main, bundle: .main)
        let movieDetailVC = storyboard.instantiateViewController(withIdentifier: ViewControllers.shared.movieDetail) as? MovieDetailViewController
        movieDetailVC?.movieId = Int(self.presenter.nowPlayingMovies[indexPath.row].id)
//        self.navigationController?.pushViewController(movieDetailVC!, animated: true)
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

