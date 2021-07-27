//
//  FavouriteMoviesPresenter.swift
//  Moview
//
//  Created by Shubham Ojha on 17/07/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import Foundation

protocol IFavouriteMoviesPresenter {
    func loadFavouriteMoviesFromNetwork(handler: @escaping FetchMoviesFromNetworkCompletionHandler)
    func loadFavouriteMoviesFromLocal(handler: @escaping FetchMoviesFromLocalDBCompletionHandler)
}

class FavouriteMoviesPresenter{
    let networkLayer: INetworkLayer
    let coreDataWorker: IMoviesCoreDataWorker
    
    init(networkLayer: INetworkLayer, coreDataWorker: IMoviesCoreDataWorker) {
        self.networkLayer = networkLayer
        self.coreDataWorker = coreDataWorker
    }
}

extension FavouriteMoviesPresenter: IFavouriteMoviesPresenter {
    func loadFavouriteMoviesFromNetwork(handler: @escaping FetchMoviesFromNetworkCompletionHandler) {
        
    }
    
    func loadFavouriteMoviesFromLocal(handler: @escaping FetchMoviesFromLocalDBCompletionHandler) {
        coreDataWorker.fetchNowPlayingMoviesFromLocalDB { (movies) -> (Void) in
            handler(movies)
        }
    }
    
    
}
