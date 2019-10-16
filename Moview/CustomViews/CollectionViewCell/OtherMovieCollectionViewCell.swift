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
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        collectionView_movie.delegate = dataSourceDelegate
        collectionView_movie.dataSource = dataSourceDelegate
        collectionView_movie.tag = row
        collectionView_movie.reloadData()
    }
}
