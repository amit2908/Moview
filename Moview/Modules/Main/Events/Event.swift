//
//  Event.swift
//  Moview
//
//  Created by Shubham Ojha on 18/06/22.
//  Copyright © 2022 Shubham. All rights reserved.
//

import Foundation

class Event: Identifiable{
    let title: String
    let time: String
    let movieId: String
    
    init(title: String,
         time: String,
         movieId: String) {
        self.title = title
        self.time = time
        self.movieId = movieId
    }
}
