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
    
    init(id: Int, logoPath: String?, name: String, originCountry: String) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.originCountry = originCountry
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
}
