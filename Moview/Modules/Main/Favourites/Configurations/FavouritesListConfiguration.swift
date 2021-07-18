//
//  MovieListConfiguration.swift
//  Moview
//
//  Created by Shubham Ojha on 17/07/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import UIKit

class FavouritesListConfiguration: ITableConfiguration {
    var numberOfSections: Int
    var sectionConfigurations: [ISectionConfiguration]
    
    let movies : [Movie]
    init(movies: [Movie]) {
        self.movies = movies
        self.numberOfSections = 1
        self.sectionConfigurations = [FavouritesListSectionConfiguration(movies: movies)]
    }
}

class FavouritesListSectionConfiguration: ISectionConfiguration {
    var numberOfRows: Int
    var cellConfigurations: [ITableCellConfiguration]
    
    init(movies: [Movie]) {
        self.numberOfRows = movies.count
        self.cellConfigurations =
            movies.map{ FavouritesListCellConfiguration(data: $0) }
    }
}

class FavouritesListCellConfiguration: ITableCellConfiguration {
    var data: Any?
    
    var cellIdentifier: String
    
    var cellHeight: CGFloat
    
    var headerView: UIView?
    
    var footerView: UIView?
    
    var headerHeight: CGFloat?
    
    var footerHeight: CGFloat?
    
    var cellDidSelectCallback: (IndexPath) -> Void
    
    init(data: Any?){
        self.data = data
        self.cellIdentifier = FavouriteMovieTableCell.reuseID
        self.cellHeight = 100.0
        self.cellDidSelectCallback = { indexPath in
            if let movie = data as? Movie {
                Navigation.shared.navigateToMovieDetail(movieId: Int(movie.id))
            }
        }
    }
    
    
}
