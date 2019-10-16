//
//  OtherMoviesCollectionPresenter.swift
//  Moview
//
//  Created by Shubham Ojha on 15/10/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation

class OtherMoviesCollectionPresenter {
    var otherMoviesCollections = [[Movie]]()
    let sections        : [String] = ["Upcoming Movies", "Latest"]
    
    fileprivate var modelLayer : ModelLayer
    
    init(modelLayer: ModelLayer) {
        self.modelLayer = modelLayer
    }
    
    func loadUpcomingMovies(page: Int, handler: @escaping FetchMoviesFromSourceCompletionHandler) {
        modelLayer.loadUpcomingMovies(from: .local, page: page) { (movies, source, error) -> (Void) in
            if (error == nil) {
                self.otherMoviesCollections.append(movies)
                handler(.local)
            }
        }
        
        modelLayer.loadUpcomingMovies(from: .network, page: 1) { (movies, source, error) -> (Void) in
            if (error == nil) {
                self.otherMoviesCollections.append(movies)
                handler(.network)
            }
        }
        
    }
}

