//
//  DashboardPresenter.swift
//  Moview
//
//  Created by Shubham Ojha on 03/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation

typealias FetchMoviesFromSourceCompletionHandler = (Source)->(Void)

class DashboardPresenter {
    var nowPlayingMovies = [Movie]()
    let otherMovies      = [Movie]()
    let sections        : [String] = ["Top Rated", "Latest", "Favourites", "Action", "Romantic"]
    
    fileprivate var modelLayer : ModelLayer
    
    init(modelLayer: ModelLayer) {
        self.modelLayer = modelLayer
    }
    
    func loadNowPlayingMovies(handler: FetchMoviesFromSourceCompletionHandler) {
        modelLayer.dataLayer.fetchNowPlayingMoviesFromLocalDB { (movies) -> (Void) in
            self.nowPlayingMovies = movies
            handler(.local)
        }
        modelLayer.networkLayer.fetchNowPlayingDataFromServer(successHandler: { (data) -> (Void) in
            
        }) { (error) -> (Void) in
            
        }
    }
}
