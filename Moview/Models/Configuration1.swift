//
//  configuration.swift
//  Moview
//
//  Created by Empower on 30/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import CoreData

/*
 extension Images: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case baseUrl = "images"
        case secureBaseUrl = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
    
    @NSManaged var baseUrl : String?
    @NSManaged var secureBaseUrl : String?
    @NSManaged var backdropSizes : NSSet?
    @NSManaged var logoSizes : NSSet?
    @NSManaged var posterSizes : NSSet?
    @NSManaged var profileSizes : NSSet?
    @NSManaged var stillSizes : NSSet?
    
    public required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Images", in: managedObjectContext) else {
                fatalError("Failed to decode Configuration")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        
    }
}

extension Configuration: Codable {
    enum CodingKeys: String, CodingKey {
        case images = "images"
        case changeKeys = "change_keys"
    }
    //Core Data Managed Object
    @NSManaged var images : Images?
    
    public required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
        let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Configuration", in: managedObjectContext) else {
                fatalError("Failed to decode Configuration")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
    
}
 */

