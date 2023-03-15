//
//  SwipeableTableCellConfiguration.swift
//  Moview
//
//  Created by Shubham Ojha on 18/06/22.
//  Copyright © 2022 Shubham. All rights reserved.
//

import Foundation


protocol ISwipeableTableCellConfiguration: ITableCellConfiguration {
    var swipeLeftCallback: (IndexPath) -> Void { get set }
}


class GenericSwipeableTableSectionConfiguration<ItemData>: GenericTableSectionConfiguration<ItemData> {
    
    var swipeableCellConfigurations: [ISwipeableTableCellConfiguration]
    
    init(itemData: [ItemData], reusedID: String, estimatedCellHeight: CGFloat?, cellDidSelectCallback: @escaping (IndexPath) -> Void, swipeLeftCallback: @escaping (IndexPath) -> Void) {
        self.swipeableCellConfigurations = itemData.map{ GenericSwipeableListCellConfiguration(data: $0,
                                                                                               cellReuseID: reusedID,
                                                                                               callback: cellDidSelectCallback, estimatedCellHeight: estimatedCellHeight, swipeLeftCallback: swipeLeftCallback) }
        super.init(itemData: itemData, reusedID: reusedID, estimatedCellHeight: estimatedCellHeight, cellDidSelectCallback: cellDidSelectCallback)
    }
}

class GenericSwipeableListCellConfiguration<CellData>: GenericListCellConfiguration<CellData>, ISwipeableTableCellConfiguration{
    var swipeLeftCallback: (IndexPath) -> Void
    
    init(data: CellData,
         cellReuseID: String,
         callback: @escaping (IndexPath) -> Void,
         estimatedCellHeight: CGFloat?,
         swipeLeftCallback: @escaping (IndexPath) -> Void){
        self.swipeLeftCallback = swipeLeftCallback
        super.init(data: data, cellReuseID: cellReuseID, estimatedCellHeight: estimatedCellHeight, callback: callback)
    }
}
