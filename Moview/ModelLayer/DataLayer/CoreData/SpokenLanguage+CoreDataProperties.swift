//
//  SpokenLanguage+CoreDataProperties.swift
//  Moview
//
//  Created by Shubham Ojha on 27/11/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import CoreData

@objc
extension SpokenLanguage {
    
    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case name
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SpokenLanguage> {
        return NSFetchRequest<SpokenLanguage>(entityName: "SpokenLanguage")
    }
}


