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
    
    //MARK: Public Properties
    let presenter : OtherMoviesCollectionPresenter
//    final var collectionOfCollectionOfMovies : [[Movie]]
    final var vc : UIViewController
    
    //MARK: Private Properties
    private var arrayOfMovieDataSources: [MovieCollectionDataSource] = [MovieCollectionDataSource]()
    
    init(presenter: OtherMoviesCollectionPresenter, vc: UIViewController) {
        self.presenter = presenter
//        self.collectionOfCollectionOfMovies = collectionOfCollectionOfMovies
        self.vc = vc
        super.init()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.otherMoviesCollections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as? SectionHeader{
            sectionHeader.sectionHeaderLabel.text = presenter.sections[indexPath.section]
            return sectionHeader
        }
        return SectionHeader()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: SCREEN_WIDTH, height: 60)
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherCellIdentifier", for: indexPath)
        
        guard let otherMovieCell = cell as? OtherMovieCollectionViewCell else {
            let newCell = OtherMovieCollectionViewCell.init()
            return newCell
        }
        
        otherMovieCell.backgroundColor = UIColor.init(red: CGFloat(indexPath.row/5), green: CGFloat(indexPath.row/5), blue: CGFloat(indexPath.row/5), alpha: 1)
        let movies = self.presenter.otherMoviesCollections[indexPath.row]
        let movieDataSource = MovieCollectionDataSource(movies: movies, vc: self.vc)
        self.arrayOfMovieDataSources.append(movieDataSource)
        otherMovieCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: movieDataSource, forRow: indexPath.row)
        otherMovieCell.collectionView_movie.reloadData()
        return otherMovieCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    
}
extension OtherMoviesDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
}
