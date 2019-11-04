//
//  ModelLayer.swift
//  Moview
//
//  Created by Shubham Ojha on 03/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation

typealias MovieFetchHandlerWithSource = ([Movie], Source, Error?)->(Void)
typealias MovieFetchDetailHandlerWithSource = (Movie?, Source, Error?)->(Void)

enum Source: Int {
    case local = 1, network
}

class ModelLayer {
    
    //MARK: Private Properties
    private let networkLayer     : NetworkLayer
    private let dataLayer        : DataLayer
    private let translationLayer : TranslationLayer
    
    
    //MARK: Public Methods
    init(networkLayer: NetworkLayer, dataLayer: DataLayer, translationLayer: TranslationLayer) {
        self.dataLayer        = dataLayer
        self.networkLayer     = networkLayer
        self.translationLayer = translationLayer
    }
    
    /// Loads Movies that are currently running in theaters
    /// - Parameter source: The source from where the movies are being fetched, i.e from Network or Local DB
    /// - Parameter handler: The handler method called after the movies have been fetched.
    
    func loadNowPlayingMovies(from source: Source,  handler : @escaping MovieFetchHandlerWithSource){
        if (source == .local) {
            self.dataLayer.fetchNowPlayingMoviesFromLocalDB { (movies) -> (Void) in
                handler(movies, .local, nil)
            }
        }else {//network
            
                self.networkLayer.fetchNowPlayingDataFromServer(successHandler: {[unowned self] (data) -> (Void) in
                
                //clear old results
                DataLayer.clearOldResults(entityName: "Movie")
                let coreDataObjects = self.translationLayer.getUnsavedCoreDataObject(type: NowPlayingResponse.self, data: data, context: DataLayer.viewContext)
                
                for movie in coreDataObjects?.results ?? [] {
                    movie.isNowPlaying = true
                }
                //save data to local
                DataLayer.saveContext(context: DataLayer.viewContext)
                
                //fetch again
                self.dataLayer.fetchNowPlayingMoviesFromLocalDB(handler: { (movies) -> (Void) in
                    handler(movies, .network , nil)
                })
                
            }) { (error) -> (Void) in
                handler([], .network, error)
            }
        }
    }
    
    /// Loads all the upcoming movies
    /// - Parameter source: The source from where the movies are being fetched, i.e from Network or Local DB
    /// - Parameter handler: The handler method called after the movies have been fetched.
    func loadUpcomingMovies(from source: Source, page: Int,  handler : @escaping MovieFetchHandlerWithSource){
        if (source == .local) {
            self.dataLayer.fetchUpcomingMoviesFromLocalDB { (movies) -> (Void) in
                handler(movies, .local, nil)
            }
        }else {//network
            
            self.networkLayer.fetchUpcomingMoviesFromServer(page: page, successHandler: {[unowned self] (data) -> (Void) in
                
                //clear old results
                DataLayer.clearOldResults(entityName: "Movie")
                let coreDataObjects = self.translationLayer.getUnsavedCoreDataObject(type: NowPlayingResponse.self, data: data, context: DataLayer.viewContext)
                
                for movie in coreDataObjects?.results ?? [] {
                    movie.isUpcoming = true
                }
                
                //save data to local
                DataLayer.saveContext(context: DataLayer.viewContext)
                
                //fetch again
                self.dataLayer.fetchUpcomingMoviesFromLocalDB(handler: { (movies) -> (Void) in
                    handler(movies, .network , nil)
                })
                
            }) { (error) -> (Void) in
                handler([], .network, error)
            }
        }
    }
    
    /// Loads all the latest movies
    /// - Parameter source: The source from where the movies are being fetched, i.e from Network or Local DB
    /// - Parameter handler: The handler method called after the movies have been fetched.
    func loadLatestMovies(from source: Source, page: Int,  handler : @escaping MovieFetchHandlerWithSource){
        if (source == .local) {
            self.dataLayer.fetchLatestMoviesFromLocalDB { (movies) -> (Void) in
                handler(movies, .local, nil)
            }
        }else {//network
            
            self.networkLayer.fetchLatestMoviesFromServer(page: page, successHandler: {[unowned self] (data) -> (Void) in
                
                //clear old results
                DataLayer.clearOldResults(entityName: "Movie")
                let coreDataObjects = self.translationLayer.getUnsavedCoreDataObject(type: NowPlayingResponse.self, data: data, context: DataLayer.viewContext)
                
                for movie in coreDataObjects?.results ?? [] {
                    movie.isLatest = true
                }
                
                //save data to local
                DataLayer.saveContext(context: DataLayer.viewContext)
                
                //fetch again
                self.dataLayer.fetchUpcomingMoviesFromLocalDB(handler: { (movies) -> (Void) in
                    handler(movies, .network , nil)
                })
                
            }) { (error) -> (Void) in
                handler([], .network, error)
            }
        }
    }
    
    
    /// Loads movie details
    /// - Parameter source: The source from where the movies are being fetched, i.e from Network or Local DB
    /// - Parameter movieId: Unique id of movie at server side
    /// - Parameter handler: The handler method called after the movies have been fetched.
    func loadMovieDetails(from source: Source, movieId: Int, handler : @escaping MovieFetchDetailHandlerWithSource){
        if (source == .local) {
            self.dataLayer.fetchMovieDetailFromLocalDB(movieId: movieId) { (movie) -> (Void) in
                handler(movie, .local, nil)
            }
        }else {//network
            
            self.networkLayer.fetchMovieDetailsFromServer(movieId: movieId, successHandler: {[unowned self] (data) -> (Void) in
                
                //clear old results
                DataLayer.clearOldResults(entityName: "Movie")
                let _ = self.translationLayer.getUnsavedCoreDataObject(type: Movie.self, data: data, context: DataLayer.viewContext)
                
                //save data to local
                DataLayer.saveContext(context: DataLayer.viewContext)
                
                //fetch again
                self.dataLayer.fetchMovieDetailFromLocalDB(movieId: movieId, handler: { (movie) -> (Void) in
                    handler(movie, .network , nil)
                })
                
            }) { (error) -> (Void) in
                handler(nil, .network, error)
            }
        }
    }
}
