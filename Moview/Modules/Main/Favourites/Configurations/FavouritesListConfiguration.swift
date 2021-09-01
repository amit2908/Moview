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
    
    let movies : [IMovie]
    init(movies: [IMovie]) {
        self.movies = movies
        self.numberOfSections = 1
        self.sectionConfigurations = [GenericTableSectionConfiguration(itemData: movies)]
    }
}

class GenericTableSectionConfiguration<ItemData>: ISectionConfiguration {
    var headerViewConfig: (UIView?, CGFloat)?
    
    var footerViewConfig: (UIView?, CGFloat)?
    
    var headerView: UIView?
    
    var footerView: UIView?
    
    var numberOfRows: Int {
        return cellConfigurations.count
    }
    
    var cellConfigurations: [ITableCellConfiguration]
    
    init(itemData: [ItemData]) {
        self.cellConfigurations =
            itemData.map{ GenericListCellConfiguration(data: $0) }
    }
}

class GenericListCellConfiguration<CellData>: ITableCellConfiguration {
    var data: Any?
    
    var cellIdentifier: String
    
    var cellHeight: CGFloat
    
    var headerView: UIView?
    
    var footerView: UIView?
    
    var headerHeight: CGFloat?
    
    var footerHeight: CGFloat?
    
    var cellDidSelectCallback: (IndexPath) -> Void
    
    init(data: CellData){
        self.data = data
        self.cellIdentifier = FavouriteMovieTableCell.reuseID
        self.cellHeight = 100.0
        self.cellDidSelectCallback = { indexPath in
            if let movie = data as? Movie {
                Navigation.shared.navigateToMovieDetail(movieId: movie.id)
            }
        }
    }
    
    
}
