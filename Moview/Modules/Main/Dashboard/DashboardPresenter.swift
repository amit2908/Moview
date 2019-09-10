//
//  DashboardPresenter.swift
//  Moview
//
//  Created by Shubham Ojha on 03/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation

class DashboardPresenter {
    let nowPlayingMovies = [Movie]()
    let otherMovies      = [Movie]()
    let sections        : [String] = ["Top Rated", "Latest", "Favourites", "Action", "Romantic"]
    
    fileprivate var modelLayer : ModelLayer
    
    init(modelLayer: ModelLayer) {
        self.modelLayer = modelLayer
    }
}
