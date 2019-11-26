//
//  ProductionCountry+CoreDataProperties.swift
//  Moview
//
//  Created by Shubham Ojha on 26/11/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import CoreData


@objc
extension ProductionCountry {
    
    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductionCountry> {
        return NSFetchRequest<ProductionCountry>(entityName: "ProductionCountry")
    }
}
