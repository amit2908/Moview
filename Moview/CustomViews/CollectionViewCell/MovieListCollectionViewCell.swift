//
//  MovieListCollectionViewCell.swift
//  Moview
//
//  Created by Shubham Ojha on 02/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell, GenericCollectionCell {
    
    @IBOutlet weak var imgV_movie: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_genre: UILabel!
    
    func configure(withData data: Any?) {
        guard let cellConfig = data as? GenericCollectionCellConfiguration, let movie = cellConfig.data as? IMovie else { return }
        let posterPath =  "https://image.tmdb.org/t/p/w200/" + movie.imageLink
        
        imgV_movie.downloaded(from: URL.init(string: posterPath) ?? URL.init(fileURLWithPath: "picture.png", isDirectory: false), contentMode: .top)
        lbl_title.text = movie.title
    }
    
}
