//
//  NowPlayingResponse.swift
//  Moview
//
//  Created by Empower on 05/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation


// MARK: - NowPlayingResponse
@objcMembers class NowPlayingResponse: NSObject, Codable {
    let results: [Movie]
    let page, totalResults: Int
    let dates: Dates?
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
    
    init(results: [Movie], page: Int, totalResults: Int, dates: Dates, totalPages: Int) {
        self.results = results
        self.page = page
        self.totalResults = totalResults
        self.dates = dates
        self.totalPages = totalPages
    }
}

// MARK: - Dates
@objcMembers class Dates: NSObject, Codable {
    let maximum, minimum: String
    
    init(maximum: String, minimum: String) {
        self.maximum = maximum
        self.minimum = minimum
    }
}
