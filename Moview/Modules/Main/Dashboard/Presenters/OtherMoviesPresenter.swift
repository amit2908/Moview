//
//  OtherMoviesCollectionPresenter.swift
//  Moview
//
//  Created by Shubham Ojha on 15/10/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import CoreData

typealias FetchMoviesCompletionHandler = ([IMovie]) -> Void

protocol IOtherMoviesPresenter {
    var sections                : [String]                      { get set }
    func loadTopRatedMovies(page: Int, handler: @escaping FetchMoviesCompletionHandler)
    func loadLatestMovie(handler: @escaping FetchMoviesCompletionHandler)
    func loadUpcomingMovies(page: Int, handler: @escaping FetchMoviesCompletionHandler)
    func loadNowPlayingMovies(page: Int, handler: @escaping FetchMoviesCompletionHandler)
}

class OtherMoviesPresenter: IOtherMoviesPresenter {
//    var otherMoviesCollections : [[Movie]] = [[], []]
    var sections                : [String] = [String]()
    var movieDataSources        : [MovieCollectionDataSource] = [MovieCollectionDataSource]()
    
    fileprivate var topRatedMoviesService: ITopRatedMoviesService
    fileprivate var latestMoviesService: ILatestMoviesService
    fileprivate var upcomingMoviesService: IUpcomingMoviesService
    fileprivate var repository: IMovieCoreDataRepository
    fileprivate var translator: ITranslationLayer
    
    init(topRatedMoviesService: ITopRatedMoviesService,
         latestMoviesService: ILatestMoviesService,
         upcomingMoviesService: IUpcomingMoviesService,
         repository: IMovieCoreDataRepository,
         translator: ITranslationLayer) {
        
        self.topRatedMoviesService = topRatedMoviesService
        self.latestMoviesService = latestMoviesService
        self.upcomingMoviesService = upcomingMoviesService
        self.repository = repository
        self.translator = translator
     
        self.sections.append("Latest Movies")
        self.sections.append("Top Rated Movies")
    }
    
    
    func loadUpcomingMovies(page: Int, handler: @escaping FetchMoviesCompletionHandler) {
        
        let movies = repository.fetchMovies(withType: .UPCOMING)
        if movies.isEmpty {
            upcomingMoviesService.fetchUpcomingMovies(page: page, successHandler: { [weak self] (data) -> (Void) in
                
                self?.repository.storeMovies(fromData: data, withType: .UPCOMING)
                
                if let movies = self?.repository.fetchMovies(withType: .UPCOMING) {
                    handler(movies)
                }
                
                return
                
            }) { (error) -> (Void) in
                debugPrint("Error while fetching Top Rated movies >>>------>", error.localizedDescription)

                handler([])
            }
        }else {
            handler(movies)
        }
        
    }
    
    func loadTopRatedMovies(page: Int, handler: @escaping FetchMoviesCompletionHandler) {
        
        let movies = repository.fetchMovies(withType: .TOP_RATED)
        if movies.isEmpty {
            topRatedMoviesService.fetchTopRatedMovies(page: page, successHandler: { [weak self] (data) -> (Void) in
                
                self?.repository.storeMovies(fromData: data, withType: .TOP_RATED)
                
                if let movies = self?.repository.fetchMovies(withType: .TOP_RATED) {
                    handler(movies)
                }
                
                return
                
            }) { (error) -> (Void) in
                debugPrint("Error while fetching Top Rated movies >>>------>", error.localizedDescription)

                handler([])
            }
        }else {
            handler(movies)
        }

        
    }
    
    
    func loadLatestMovie(handler: @escaping FetchMoviesCompletionHandler) {
        
        let movies = repository.fetchMovies(withType: .LATEST)
        if movies.isEmpty {
            latestMoviesService.fetchLatestMovies(successHandler: { [weak self] (data) -> (Void) in
                
                self?.repository.storeMovies(fromData: data, withType: .LATEST)
                
                if let movies = self?.repository.fetchMovies(withType: .LATEST) {
                    handler(movies)
                }
                
                return
                
            }) { (error) -> (Void) in
                debugPrint("Error while fetching Top Rated movies >>>------>", error.localizedDescription)

                handler([])
            }
        }else {
            handler(movies)
        }
        
    }
    
    func loadNowPlayingMovies(page: Int, handler: @escaping FetchMoviesCompletionHandler) {
        let movies = repository.fetchMovies(withType: .NOW_PLAYING)
        if movies.isEmpty {
            latestMoviesService.fetchLatestMovies(successHandler: { [weak self] (data) -> (Void) in
                
                self?.repository.storeMovies(fromData: data, withType: .NOW_PLAYING)
                
                if let movies = self?.repository.fetchMovies(withType: .NOW_PLAYING) {
                    handler(movies)
                }
                
                return
                
            }) { (error) -> (Void) in
                debugPrint("Error while fetching Top Rated movies >>>------>", error.localizedDescription)

                handler([])
            }
        }else {
            handler(movies)
        }
    }
}

