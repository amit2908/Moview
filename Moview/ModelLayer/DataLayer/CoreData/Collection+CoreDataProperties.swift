//
//  Collection+CoreDataProperties.swift
//  Moview
//
//  Created by Shubham Ojha on 27/11/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import CoreData


@objc
extension Collection {
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Collection> {
        return NSFetchRequest<Collection>(entityName: "Collection")
    }
}

