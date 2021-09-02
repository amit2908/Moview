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
    var movieDataSources        : [MovieCollectionDataSource]   { get set }
    func loadTopRatedMovies(page: Int, handler: @escaping FetchMoviesCompletionHandler)
    func loadLatestMovie(handler: @escaping FetchMoviesCompletionHandler)
}

class OtherMoviesPresenter: IOtherMoviesPresenter {
//    var otherMoviesCollections : [[Movie]] = [[], []]
    var sections                : [String] = [String]()
    var movieDataSources        : [MovieCollectionDataSource] = [MovieCollectionDataSource]()
    
    fileprivate var topRatedMoviesService: ITopRatedMoviesService
    fileprivate var latestMoviesService: ILatestMoviesService
    fileprivate var repository: IMovieCoreDataRepository
    fileprivate var translator: ITranslationLayer
    
    init(topRatedMoviesService: ITopRatedMoviesService,
         latestMoviesService: ILatestMoviesService,
         repository: IMovieCoreDataRepository,
         translator: ITranslationLayer) {
        
        self.topRatedMoviesService = topRatedMoviesService
        self.latestMoviesService = latestMoviesService
        self.repository = repository
        self.translator = translator
     
        self.sections.append("Latest Movies")
        self.sections.append("Top Rated Movies")
        self.movieDataSources.append(MovieCollectionDataSource(movies: [IMovie]()))
        self.movieDataSources.append(MovieCollectionDataSource(movies: [IMovie]()))
    }
    
    
    func loadUpcomingMovies(page: Int, handler: @escaping FetchMoviesCompletionHandler) {
        
        
    }
    
    func loadTopRatedMovies(page: Int, handler: @escaping FetchMoviesCompletionHandler) {
        
        let movies = repository.fetchMovies(withType: .TOP_RATED)
        if movies.isEmpty {
            topRatedMoviesService.fetchTopRatedMovies(page: page, successHandler: { (data) -> (Void) in
                
                DataLayer.persistentContainer.performBackgroundTask { (context) in
                    context.mergePolicy = NSMergePolicy.init(merge: .mergeByPropertyObjectTrumpMergePolicyType)
                    
                    let response : NowPlayingResponse? = self.translator.getUnsavedCoreDataObject(type: NowPlayingResponse.self, data: data, context: context)
                    
                    response?.results.forEach {
                        $0.type = Int64.init(truncatingIfNeeded: MovieTypes.TOP_RATED.rawValue)
                    }
                    
                    DataLayer.saveContext(context: context)
                }
                
                let movies = self.repository.fetchMovies(withType: .TOP_RATED)
                handler(movies)
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
            latestMoviesService.fetchLatestMovies(successHandler: { (data) -> (Void) in
                
                DataLayer.persistentContainer.performBackgroundTask { (context) in
                    context.mergePolicy = NSMergePolicy.init(merge: .mergeByPropertyObjectTrumpMergePolicyType)
                    
                    let response : NowPlayingResponse? = self.translator.getUnsavedCoreDataObject(type: NowPlayingResponse.self, data: data, context: context)
                    
                    response?.results.forEach {
                        $0.type = Int64.init(truncatingIfNeeded: MovieTypes.LATEST.rawValue)
                    }
                    
                    DataLayer.saveContext(context: context)
                }
                
                let movies = self.repository.fetchMovies(withType: .LATEST)
                handler(movies)
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

