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
    @NSManaged public var original_language: String
    @NSManaged public var original_title: String?
    @NSManaged public var genre_ids: [Int16]?
    @NSManaged public var backdrop_path: String?
    @NSManaged public var adult: Bool
    @NSManaged public var overview: String?
    @NSManaged public var release_date: String?
    

}
