//
//  ProductionCompany+CoreDataClass.swift
//  Moview
//
//  Created by Shubham Ojha on 26/11/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import CoreData

// MARK: - ProductionCompany
@objc(ProductionCompany)
public class ProductionCompany: NSManagedObject, Codable {
    @NSManaged var id: Int64
    @NSManaged var logoPath: String?
    @NSManaged var name: String?
    @NSManaged var originCountry: String?
    
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "ProductionCompany", in: managedObjectContext) else {
                fatalError("Failed to decode Configuration")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let container               = try decoder.container(keyedBy: CodingKeys.self)
        self.id                     = try (container.decodeIfPresent(Int64.self, forKey: .id) ?? 0)
        self.logoPath               = try container.decodeIfPresent(String.self,   forKey: .logoPath) ?? ""
        self.name                   = try (container.decodeIfPresent(String.self,   forKey: .name) ?? "")
        self.originCountry          = try (container.decodeIfPresent(String.self,    forKey: .originCountry) ?? "")
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id                    , forKey: .id)
        try container.encode(self.logoPath              , forKey: .logoPath)
        try container.encode(self.name                  , forKey: .name)
        try container.encode(self.originCountry         , forKey: .originCountry)
    }
    
    
//    init(id: Int, logoPath: String?, name: String, originCountry: String) {
//        self.id = id
//        self.logoPath = logoPath
//        self.name = name
//        self.originCountry = originCountry
//    }
    
    
}
