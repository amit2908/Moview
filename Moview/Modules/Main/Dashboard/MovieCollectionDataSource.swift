//
//  MovieCollectionDataSource.swift
//  Moview
//
//  Created by Shubham Ojha on 15/10/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import CoreData

class MovieCollectionDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
   final var movies : [Movie]
   final var sections : [String]
    final var vc : UIViewController
    
    init(movies: [Movie], sections: [String], vc: UIViewController) {
        self.movies = movies
        self.sections = sections
        self.vc = vc
        super.init()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCellIdentifier", for: indexPath)
        guard let movieCell = cell as? MovieCollectionViewCell else {
            let newCell = MovieCollectionViewCell.init()
            newCell.lbl_title.text = self.movies[indexPath.row].title
            newCell.backgroundColor = UIColor.init(red: CGFloat(indexPath.row/5), green: CGFloat(indexPath.row/5), blue: CGFloat(indexPath.row/5), alpha: 1)
            return newCell
        }
        movieCell.lbl_title.text = self.movies[indexPath.row].title
        movieCell.backgroundColor = UIColor.init(red: CGFloat(indexPath.row/5), green: CGFloat(indexPath.row/5), blue: CGFloat(indexPath.row/5), alpha: 1)
        return movieCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       let collectionCell = cell as? MovieCollectionViewCell
       let posterPath = movies[indexPath.row].poster_path != nil ? "https://image.tmdb.org/t/p/w500/" + movies[indexPath.row].poster_path! : ""
       collectionCell?.imgV_movie.downloaded(from: URL.init(string: posterPath) ?? URL.init(fileURLWithPath: "picture.png", isDirectory: false), contentMode: .top)
                        collectionCell?.lbl_title.text = movies[indexPath.row].original_title
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Storyboards.shared.main, bundle: .main)
        let movieDetailVC = storyboard.instantiateViewController(withIdentifier: ViewControllers.shared.movieDetail) as? MovieDetailViewController
        movieDetailVC?.movieId = Int(self.movies[indexPath.row].id)
        self.vc.navigationController?.pushViewController(movieDetailVC!, animated: true)
    }
    
}
extension MovieCollectionDataSource: UICollectionViewDelegateFlowLayout {
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: SCREEN_WIDTH/4, height: SCREEN_WIDTH/5)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
}


