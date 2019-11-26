//
//  Collection+CoreDataClass.swift
//  Moview
//
//  Created by Shubham Ojha on 26/11/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import CoreData


// MARK: - BelongsToCollection
@objc(Collection)

public class Collection: NSManagedObject, Codable {
    @NSManaged var id: Int64
    @NSManaged var name, posterPath, backdropPath: String
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Collection", in: managedObjectContext) else {
                fatalError("Failed to decode Configuration")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let container               = try decoder.container(keyedBy: CodingKeys.self)
        self.id                     = try (container.decodeIfPresent(Int64.self, forKey: .id) ?? 0)
        self.name                   = try container.decodeIfPresent(String.self,   forKey: .name) ?? ""
        self.posterPath             = try (container.decodeIfPresent(String.self, forKey: .posterPath) ?? "")
        self.backdropPath           = try container.decodeIfPresent(String.self,   forKey: .backdropPath) ?? ""
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id                    , forKey: .id)
        try container.encode(self.posterPath              , forKey: .posterPath)
        try container.encode(self.name                  , forKey: .name)
        try container.encode(self.backdropPath         , forKey: .backdropPath)
    }
    
}

