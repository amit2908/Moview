//
//  MovieListDataSource.swift
//  Moview
//
//  Created by Shubham Ojha on 02/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import CoreData

class MovieListDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let movieListViewModel : MovieListViewModel
    
    final weak var vc: UIViewController?
    
    init(movieListViewModel: MovieListViewModel, vc: MovieListViewController) {
        self.movieListViewModel = movieListViewModel
        self.vc = vc
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieListViewModel.movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCellIdentifier", for: indexPath)
        guard let otherMovieCell = cell as? MovieListCollectionViewCell else {
            let newCell = MovieCollectionViewCell.init()
            return newCell
        }
        
        return otherMovieCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let collectionCell = cell as? MovieListCollectionViewCell
        let posterPath =  "https://image.tmdb.org/t/p/w200/" + movieListViewModel.movies[indexPath.row].imageLink
        
        collectionCell?.imgV_movie.downloaded(from: URL.init(string: posterPath) ?? URL.init(fileURLWithPath: "picture.png", isDirectory: false), contentMode: .top)
        collectionCell?.lbl_title.text = movieListViewModel.movies[indexPath.row].title
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let storyboard = UIStoryboard(name: Storyboards.shared.main, bundle: .main)
        //        let movieDetailVC = storyboard.instantiateViewController(withIdentifier: ViewControllers.shared.movieDetail) as? MovieDetailViewController
        //        movieDetailVC?.movieId = Int(self.nowPlayingMovies[indexPath.row].id)
        //        self.navigationController?.pushViewController(movieDetailVC!, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let movie = movieListViewModel.movies.remove(at: sourceIndexPath.item)
        movieListViewModel.movies.insert(movie, at: destinationIndexPath.item)
    }
    
}
extension MovieListDataSource: UICollectionViewDelegateFlowLayout {
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH * 0.6, height: SCREEN_HEIGHT/5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }*/


}

