//
//  OtherMoviesDataSource.swift
//  Moview
//
//  Created by Empower on 22/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import CoreData

class OtherMoviesDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var movies : [Movie]
    
    var sections : [String]
    
    init(movies: [Movie], sections: [String]) {
        self.movies = movies
        self.sections = sections
        super.init()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as? SectionHeader{
            sectionHeader.sectionHeaderLabel.text = self.sections[indexPath.section]
            return sectionHeader
        }
        return SectionHeader()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherCellIdentifier", for: indexPath)
        guard let otherMovieCell = cell as? OtherMovieCollectionViewCell else {
            let newCell = OtherMovieCollectionViewCell.init()
            return newCell
        }
        otherMovieCell.backgroundColor = UIColor.init(red: CGFloat(indexPath.row/5), green: CGFloat(indexPath.row/5), blue: CGFloat(indexPath.row/5), alpha: 1)
        return otherMovieCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       let collectionCell = cell as? OtherMovieCollectionViewCell
       let posterPath = movies[indexPath.row].poster_path != nil ? "https://image.tmdb.org/t/p/w500/" + movies[indexPath.row].poster_path! : ""
       collectionCell?.imgV_movie.downloaded(from: URL.init(string: posterPath) ?? URL.init(fileURLWithPath: "picture.png", isDirectory: false), contentMode: .top)
                        collectionCell?.lbl_title.text = movies[indexPath.row].original_title
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: Storyboards.shared.main, bundle: .main)
//        let movieDetailVC = storyboard.instantiateViewController(withIdentifier: ViewControllers.shared.movieDetail) as? MovieDetailViewController
//        movieDetailVC?.movieId = Int(self.nowPlayingMovies[indexPath.row].id)
//        self.navigationController?.pushViewController(movieDetailVC!, animated: true)
    }
    
}
extension OtherMoviesDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH/4, height: SCREEN_WIDTH/5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
}
