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
        
        let container               = try decoder.container(keyedBy: CodingKeys.self)
        self.genre_ids              = try container.decodeIfPresent([Int16].self, forKey: .genre_ids)
        self.vote_count             = try container.decodeIfPresent(Int64.self,   forKey: .vote_count) ?? -1
        self.id                     = try container.decodeIfPresent(Int32.self,   forKey: .id) ?? -1
        self.video                  = try container.decodeIfPresent(Bool.self,    forKey: .video) ?? false
        self.vote_average           = try container.decodeIfPresent(Float.self,   forKey: .vote_average) ?? -1.0
        self.popularity             = try container.decodeIfPresent(Double.self,  forKey: .popularity) ?? -1.0
        self.poster_path            = try container.decodeIfPresent(String.self,  forKey: .poster_path)
        self.original_language      = try container.decodeIfPresent(String.self,  forKey: .original_language)
        self.original_title         = try container.decodeIfPresent(String.self,  forKey: .original_title)
        self.backdrop_path          = try container.decodeIfPresent(String.self,  forKey: .backdrop_path)
        self.overview               = try container.decodeIfPresent(String.self,  forKey: .overview)
        self.release_date           = try container.decodeIfPresent(String.self,  forKey: .overview)
        self.adult                  = try container.decodeIfPresent(Bool.self, forKey: .adult) ?? false
        self.belongsToCollection    = try container.decodeIfPresent(BelongsToCollection.self , forKey: .belongsToCollection)
        self.budget                 = try container.decodeIfPresent(Int64.self , forKey: .budget) ?? -1
        self.homepage               = try container.decodeIfPresent(String.self , forKey: .homepage)
        self.imdbID                 = try container.decodeIfPresent(String.self , forKey: .imdbID)
        self.productionCompanies    = try container.decodeIfPresent([ProductionCompany].self , forKey: .productionCompanies)
        self.productionCountries    = try container.decodeIfPresent([ProductionCountry].self , forKey: .productionCountries)
        self.revenue                = try container.decodeIfPresent(Int64.self, forKey: .revenue) ?? -1
        self.runtime                = try container.decodeIfPresent(Int64.self, forKey: .runtime) ?? -1
        self.spokenLanguages        = try container.decodeIfPresent([SpokenLanguage].self, forKey: .spokenLanguages)
        self.status                 = try container.decodeIfPresent(String.self, forKey: .status)
        self.tagline                = try container.decodeIfPresent(String.self, forKey: .tagline)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.adult                 , forKey: .adult)
        try container.encode(self.genre_ids             , forKey: .genre_ids)
        try container.encode(self.vote_count            , forKey: .vote_count)
        try container.encode(self.id                    , forKey: .id)
        try container.encode(self.video                 , forKey: .video)
        try container.encode(self.vote_average          , forKey: .vote_average)
        try container.encode(self.popularity            , forKey: .popularity)
        try container.encode(self.poster_path           , forKey: .poster_path)
        try container.encode(self.original_language     , forKey: .original_language)
        try container.encode(self.original_title        , forKey: .original_title)
        try container.encode(self.backdrop_path         , forKey: .backdrop_path)
        try container.encode(self.overview              , forKey: .overview)
        try container.encode(self.release_date          , forKey: .release_date)
        try container.encode(self.adult                 , forKey: .adult)
        try container.encode(self.belongsToCollection   , forKey: .belongsToCollection)
        try container.encode(self.budget                , forKey: .budget)
        try container.encode(self.homepage              , forKey: .homepage)
        try container.encode(self.imdbID                , forKey: .imdbID)
        try container.encode(self.productionCompanies   , forKey: .productionCompanies)
        try container.encode(self.productionCountries   , forKey: .productionCountries)
        try container.encode(self.revenue               , forKey: .revenue)
        try container.encode(self.runtime               , forKey: .runtime)
        try container.encode(self.spokenLanguages       , forKey: .spokenLanguages)
        try container.encode(self.status                , forKey: .status)
        try container.encode(self.tagline               , forKey: .tagline)
    }

}
