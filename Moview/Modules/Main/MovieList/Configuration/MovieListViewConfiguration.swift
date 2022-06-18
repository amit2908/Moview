//
//  MovieListViewConfiguration.swift
//  Moview
//
//  Created by Shubham Ojha on 17/06/22.
//  Copyright © 2022 Shubham. All rights reserved.
//

import UIKit

class MovieListViewConfiguration: NSObject, ICollectionViewConfiguration {
    var numberOfSections: Int
    var sectionConfigurations: [ICollectionViewSectionConfiguration]
    
    let movies : [IMovie]
    
    init(movies: [IMovie], cellDidSelectCallback: @escaping (IndexPath) -> Void) {
        self.movies = movies
        self.numberOfSections = 1
        self.sectionConfigurations = [GenericCollectionSectionConfiguration(itemData: movies, reusedID: MovieListCollectionViewCell.reuseID, cellDidSelectCallback: cellDidSelectCallback)]
    }
    
}

class GenericCollectionSectionConfiguration<ItemData>: ICollectionViewSectionConfiguration {
    var itemConfigurations: [ICollectionItemConfiguration]
    
    var numberOfRows: Int {
        return itemConfigurations.count
    }
    
    
    init(itemData: [ItemData], reusedID: String, cellDidSelectCallback: @escaping (IndexPath) -> Void) {
        self.itemConfigurations =
            itemData.map{ GenericCollectionCellConfiguration(data: $0,
                                                             cellReuseID: reusedID,
                                                             height: 100.0,
                                                             width: 100.0,
                                                             callback: cellDidSelectCallback) }
    }
}

class GenericCollectionCellConfiguration: ICollectionItemConfiguration {
   
    var width: CGFloat
    
    var height: CGFloat
    
    var cellIdentifier: String
    
    var data: Any?
    
    var cellDidSelectCallback: (IndexPath) -> Void
    
    init(data: Any, cellReuseID: String, height: CGFloat, width: CGFloat, callback: @escaping (IndexPath) -> Void){
        self.data = data
        self.cellIdentifier = cellReuseID
        self.height = height
        self.width = width
        self.cellDidSelectCallback = callback
    }
    
    
}
