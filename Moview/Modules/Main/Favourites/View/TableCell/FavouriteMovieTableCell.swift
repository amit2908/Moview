//
//  FavouriteMovieTableCell.swift
//  Moview
//
//  Created by Shubham Ojha on 17/07/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import UIKit

class FavouriteMovieTableCell: UITableViewCell, GenericTableCell {
    
    func configure(withData data: Any?) {
        if let movie = data as? Movie {
            self.textLabel?.text = movie.original_title
        }
    }
    
}
