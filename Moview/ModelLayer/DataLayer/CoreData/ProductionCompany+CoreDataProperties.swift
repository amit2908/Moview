//
//  ProductionCompany+CoreDataProperties.swift
//  Moview
//
//  Created by Shubham Ojha on 26/11/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import CoreData

@objc
extension ProductionCompany {
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductionCompany> {
        return NSFetchRequest<ProductionCompany>(entityName: "ProductionCompany")
    }
}
