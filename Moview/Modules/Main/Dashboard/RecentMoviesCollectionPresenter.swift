//
//  DashboardPresenter.swift
//  Moview
//
//  Created by Shubham Ojha on 03/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation

typealias FetchMoviesFromSourceCompletionHandler = (Source)->(Void)
typealias FetchMoviesFromNetworkCompletionHandler = (Data)->(Void)
typealias FetchMoviesFromLocalDBCompletionHandler = ([Movie])->(Void)

class RecentMoviesCollectionPresenter {
    var nowPlayingMovies = [Movie]()
    let otherMovies      = [Movie]()
    let sections        : [String] = ["Top Rated", "Latest", "Favourites", "Action", "Romantic"]
    
    fileprivate var modelLayer : ModelLayer
    
    init(modelLayer: ModelLayer) {
        self.modelLayer = modelLayer
    }
    
    func loadNowPlayingMovies(handler: @escaping FetchMoviesFromSourceCompletionHandler) {
        modelLayer.loadNowPlayingMovies(from: .local) { (movies, source, error) -> (Void) in
            if (error == nil) {
                self.nowPlayingMovies = movies
                handler(.local)
            }
        }
        
        modelLayer.loadNowPlayingMovies(from: .network) { (movies, source, error) -> (Void) in
            if (error == nil) {
                self.nowPlayingMovies = movies
                handler(.network)
            }
        }
        
    }
}
