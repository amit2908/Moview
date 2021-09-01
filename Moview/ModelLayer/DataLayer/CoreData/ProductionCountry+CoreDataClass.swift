//
//  ProductionCountry.swift
//  Moview
//
//  Created by Shubham Ojha on 26/11/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import CoreData


// MARK: - ProductionCountry
@objc(ProductionCountry)
public class ProductionCountry: NSManagedObject, Codable {
    @NSManaged var iso3166_1, name: String
    
    required convenience public init(from decoder: Decoder) throws {
        guard let managedObjectContext = decoder.userInfo[CodingUserInfoKey.managedObjectContext!] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
         guard let entity = NSEntityDescription.entity(forEntityName: "ProductionCountry", in: managedObjectContext) else {
                fatalError("Failed to decode Configuration")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.iso3166_1 = try (container.decodeIfPresent(String.self, forKey: .iso3166_1) ?? "")
            self.name = try container.decodeIfPresent(String.self,   forKey: .name) ?? ""
        } catch {
            print("Exception in decoding >>>>-------->",error.localizedDescription)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name      , forKey: .name)
        try container.encode(self.iso3166_1 , forKey: .iso3166_1)
    }
    
}
