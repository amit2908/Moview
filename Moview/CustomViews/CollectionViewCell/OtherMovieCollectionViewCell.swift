//
//  OtherMovieCellCollectionViewCell.swift
//  Moview
//
//  Created by Empower on 22/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

class OtherMovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionView_movie: UICollectionView!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        collectionView_movie.delegate = nil
        collectionView_movie.dataSource = nil
        collectionView_movie.tag = 0
    }
    
}
extension OtherMovieCollectionViewCell {
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        collectionView_movie.delegate = dataSourceDelegate
        collectionView_movie.dataSource = dataSourceDelegate
        collectionView_movie.tag = row
    }
    
    func reloadMoviesCollection() {
        self.collectionView_movie.reloadData()
    }
}
