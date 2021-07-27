//
//  FavouriteMovieTableCell.swift
//  Moview
//
//  Created by Shubham Ojha on 17/07/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import UIKit

class FavouriteMovieTableCell: UITableViewCell, GenericTableCell {
    @IBOutlet var imgV_poster: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblSubTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    
    func configure(withData data: Any?) {
        if let movie = data as? Movie {
            self.lblTitle?.text = movie.original_title
            self.lblSubTitle?.text = movie.status
            self.lblDescription.text = movie.overview
            
            if var posterPath = movie.poster_path  {
                posterPath = "https://image.tmdb.org/t/p/w92" + posterPath
                imgV_poster.sd_setImage(with: URL.init(string: posterPath) ?? URL.init(fileURLWithPath: "picture.png"))
            }
        }
    }
    
}
