//
//  Movie+CoreDataProperties.swift
//  Moview
//
//  Created by Empower on 22/05/19.
//  Copyright © 2019 Shubham. All rights reserved.
//
//

import Foundation
import CoreData

@objc
extension Movie {
    
    enum CodingKeys : String, CodingKey {
        case vote_count = "vote_count"
        case id        = "id"
        case video     = "video"
        case vote_average = "vote_average"
        case popularity = "popularity"
        case poster_path = "poster_path"
        case original_language = "original_language"
        case original_title = "original_title"
        case genre_ids = "genre_ids"
        case backdrop_path = "backdrop_path"
        case adult = "adult"
        case overview = "overview"
        case release_date = "release_date"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case homepage
        case imdbID
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title
        
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var vote_count: Int64
    @NSManaged public var id: Int32
    @NSManaged public var video: Bool
    @NSManaged public var vote_average: Float
    @NSManaged public var title: String?
    @NSManaged public var popularity: Double
    @NSManaged public var poster_path: String?
    @NSManaged public var original_language: String?
    @NSManaged public var original_title: String?
    @NSManaged public var genre_ids: [Int16]?
    @NSManaged public var backdrop_path: String?
    @NSManaged public var adult: Bool
    @NSManaged public var overview: String?
    @NSManaged public var release_date: String?
    @NSManaged public var belongsToCollection: BelongsToCollection?
    @NSManaged public var budget: Int64
    @NSManaged public var homepage: String?
    @NSManaged public var imdbID: String?
    @NSManaged public var productionCompanies: [ProductionCompany]?
    @NSManaged public var productionCountries: [ProductionCountry]?
    @NSManaged public var revenue, runtime: Int64
    @NSManaged public var spokenLanguages: [SpokenLanguage]?
    @NSManaged public var status, tagline: String?
    
    @NSManaged public var isLatest : Bool
    @NSManaged public var isNowPlaying : Bool
    @NSManaged public var isUpcoming : Bool
}

// MARK: - BelongsToCollection
@objcMembers public class BelongsToCollection: NSObject, Codable {
    let id: Int
    let name, posterPath, backdropPath: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    
    init(id: Int, name: String, posterPath: String, backdropPath: String) {
        self.id = id
        self.name = name
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id                    , forKey: .id)
        try container.encode(self.posterPath              , forKey: .posterPath)
        try container.encode(self.name                  , forKey: .name)
        try container.encode(self.backdropPath         , forKey: .backdropPath)
    }
}

// MARK: - ProductionCompany
@objcMembers public class ProductionCompany: NSObject, Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
    /*
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
        
        self.isLatest               = false
        self.isNowPlaying           = false
        self.isUpcoming             = false
    }
    */
    
    init(id: Int, logoPath: String?, name: String, originCountry: String) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.originCountry = originCountry
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id                    , forKey: .id)
        try container.encode(self.logoPath              , forKey: .logoPath)
        try container.encode(self.name                  , forKey: .name)
        try container.encode(self.originCountry         , forKey: .originCountry)
    }
}


// MARK: - ProductionCountry
@objcMembers public class ProductionCountry: NSObject, Codable {
    let iso3166_1, name: String
    
    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
    
    init(iso3166_1: String, name: String) {
        self.iso3166_1 = iso3166_1
        self.name = name
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.iso3166_1             , forKey: .iso3166_1)
        try container.encode(self.name                  , forKey: .name)
    }
    
}

// MARK: - SpokenLanguage
@objcMembers public class SpokenLanguage: NSObject, Codable {
    let iso639_1, name: String
    
    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case name
    }
    
    init(iso639_1: String, name: String) {
        self.iso639_1 = iso639_1
        self.name = name
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.iso639_1             , forKey: .iso639_1)
        try container.encode(self.name                  , forKey: .name)
    }
}
