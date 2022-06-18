//
//  FavouriteMovieTableCell.swift
//  Moview
//
//  Created by Shubham Ojha on 17/07/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import UIKit
import SwipeCellKit

class FavouriteMovieTableCell: SwipeTableViewCell, GenericTableCell {
    @IBOutlet var imgV_poster: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(withData data: Any?) {
        if let movie = data as? IMovie {
            self.lblTitle?.text = movie.title
            self.lblDescription.text = movie.overview
            let posterPath = "https://image.tmdb.org/t/p/w92" + movie.imageLink
            imgV_poster.sd_setImage(with: URL.init(string: posterPath) ?? URL.init(fileURLWithPath: "picture.png"))
        }
    }
    
}
