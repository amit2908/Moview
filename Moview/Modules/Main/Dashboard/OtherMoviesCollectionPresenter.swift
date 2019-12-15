//
//  OtherMoviesCollectionPresenter.swift
//  Moview
//
//  Created by Shubham Ojha on 15/10/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation

class OtherMoviesCollectionPresenter {
//    var otherMoviesCollections : [[Movie]] = [[], []]
    let sections        : [String] = ["Upcoming Movies", "Top Rated"]
    var movieDataSources : [MovieCollectionDataSource] = [MovieCollectionDataSource]()
    fileprivate var modelLayer : ModelLayer
    
    init(modelLayer: ModelLayer) {
        self.modelLayer = modelLayer
        
        for _ in sections {
            self.movieDataSources.append(MovieCollectionDataSource())
        }
        
    }
    
    func loadUpcomingMovies(page: Int, handler: @escaping FetchMoviesFromSourceCompletionHandler) {
        modelLayer.loadUpcomingMovies(from: .local, page: page) { (movies, source, error) -> (Void) in
            if (error == nil) {
                if movies.count != 0 {
                    self.movieDataSources[0] = MovieCollectionDataSource(movies: movies)
                }
                handler(.local)
            }
        }
        
        modelLayer.loadUpcomingMovies(from: .network, page: page) { (movies, source, error) -> (Void) in
            if (error == nil) {
                if movies.count != 0 {
                    self.movieDataSources[0] = MovieCollectionDataSource(movies: movies)
                }
                handler(.network)
            }
        }
        
    }
    
    func loadTopRatedMovies(page: Int, handler: @escaping FetchMoviesFromSourceCompletionHandler) {
        modelLayer.loadTopRatedMovies(from: .local, page: page) { (movies, source, error) -> (Void) in
            if (error == nil) {
                if movies.count != 0 {
                    self.movieDataSources[1] = MovieCollectionDataSource(movies: movies)
                }
                handler(.local)
            }
        }
        
        modelLayer.loadTopRatedMovies(from: .network, page: page) { (movies, source, error) -> (Void) in
            if (error == nil) {
                if movies.count != 0 {
                    self.movieDataSources[1] = MovieCollectionDataSource(movies: movies)
                }
                handler(.network)
            }
        }
        
    }
    
    
    func loadLatestMovie( handler: @escaping FetchMoviesFromSourceCompletionHandler) {
        modelLayer.loadLatestMovies(from: .local) { (movies, source, error) -> (Void) in
            if (error == nil) {
                if movies.count != 0 {
                    self.movieDataSources[1] = MovieCollectionDataSource(movies: movies)
                }
                handler(.local)
            }
        }
        
        modelLayer.loadLatestMovies(from: .network) { (movies, source, error) -> (Void) in
            if (error == nil) {
                if movies.count != 0 {
                    self.movieDataSources[1] = MovieCollectionDataSource(movies: movies)
                }
                handler(.network)
            }
        }
        
    }
}

