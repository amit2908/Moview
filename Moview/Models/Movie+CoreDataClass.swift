//
//  Movie+CoreDataClass.swift
//  Moview
//
//  Created by Empower on 22/05/19.
//  Copyright © 2019 Shubham. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject, Codable {
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedObjectContext) else {
                fatalError("Failed to decode Configuration")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.adult = try container.decode(Bool.self, forKey: .adult)
        self.genre_ids = try container.decode([Int16].self, forKey: .genre_ids)
        self.vote_count = try container.decode(Int64.self, forKey: .vote_count)
        self.id        = try container.decode(Int32.self, forKey: .id)
        self.video     = try container.decode(Bool.self, forKey: .video)
        self.vote_average = try container.decode(Float.self, forKey: .vote_average)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.poster_path = try container.decode(String.self, forKey: .poster_path)
        self.original_language = try container.decode(String.self, forKey: .original_language)
        self.original_title = try container.decode(String.self, forKey: .original_title)
        self.backdrop_path = try container.decode(String.self, forKey: .backdrop_path)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.release_date = try container.decode(String.self, forKey: .overview)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.adult, forKey: .adult)
        try container.encode(self.genre_ids, forKey: .genre_ids)
        try container.encode(self.vote_count, forKey: .vote_count)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.video, forKey: .video)
        try container.encode(self.vote_average, forKey: .vote_average)
        try container.encode(self.popularity, forKey: .popularity)
        try container.encode(self.poster_path, forKey: .poster_path)
        try container.encode(self.original_language, forKey: .original_language)
        try container.encode(self.original_title, forKey: .original_title)
        try container.encode(self.backdrop_path, forKey: .backdrop_path)
        try container.encode(self.overview, forKey: .overview)
        try container.encode(self.release_date, forKey: .release_date)
    }

}
