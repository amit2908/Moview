//
//  configuration.swift
//  Moview
//
//  Created by Empower on 30/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import CoreData

class Images: Decodable {
    let baseUrl : String?
    let secureBaseUrl : String?
    let backdropSizes : Array<String>?
    let logoSizes : Array<String>?
    let posterSizes : Array<String>?
    let profileSizes : Array<String>?
    let stillSizes : Array<String>?
}

class Configuration: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case images = "images"
        case changeKeys = "change_keys"
    }
    //Core Data Managed Object
    @NSManaged var images : Images?
    
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
        let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Configuration", in: managedObjectContext) else {
                fatalError("Failed to decode Configuration")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
}
