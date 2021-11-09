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
    
    init(movies: [IMovie], cellDidSelectCallback: @escaping (IndexPath) -> Void) {
        self.movies = movies
        self.numberOfSections = 1
        self.sectionConfigurations = [GenericTableSectionConfiguration(itemData: movies, reusedID: FavouriteMovieTableCell.reuseID, cellDidSelectCallback: cellDidSelectCallback)]
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
    
    init(itemData: [ItemData], reusedID: String, cellDidSelectCallback: @escaping (IndexPath) -> Void) {
        self.cellConfigurations =
            itemData.map{ GenericListCellConfiguration(data: $0, cellReuseID: reusedID, callback: cellDidSelectCallback) }
    }
}

class GenericListCellConfiguration<CellData>: ITableCellConfiguration {
    var estimatedCellHeight: CGFloat?
    
    var data: Any?
    
    var cellIdentifier: String
    
    var cellHeight: CGFloat
    
    var headerView: UIView?
    
    var footerView: UIView?
    
    var headerHeight: CGFloat?
    
    var footerHeight: CGFloat?
    
    var cellDidSelectCallback: (IndexPath) -> Void
    
    init(data: CellData, cellReuseID: String, callback: @escaping (IndexPath) -> Void){
        self.data = data
        self.cellIdentifier = cellReuseID
        self.cellHeight = UITableView.automaticDimension
        self.estimatedCellHeight = UITableView.automaticDimension
        self.cellDidSelectCallback = callback
    }
    
    
}
