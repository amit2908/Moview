//
//  DashboardPresenter.swift
//  Moview
//
//  Created by Shubham Ojha on 03/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import CoreData

protocol IRecentMoviesPresenter {
    func loadNowPlayingMovies(handler: @escaping ([IMovie]) -> Void)
}

class RecentMoviesPresenter: IRecentMoviesPresenter {
    var nowPlayingMovies = [Movie]()
    let sections : [String] = ["Top Rated", "Latest", "Favourites", "Action", "Romantic"]
    
    fileprivate var service: INowPlayingDataService
    fileprivate var repository: IMovieCoreDataRepository
    fileprivate var translator: ITranslationLayer
    
    init(service: INowPlayingDataService,
         repository: IMovieCoreDataRepository,
         translator: ITranslationLayer) {
        self.service = service
        self.repository = repository
        self.translator = translator
    }
    
    func loadNowPlayingMovies(handler: @escaping ([IMovie]) -> Void) {
        
        let movies = repository.fetchMovies(withType: MovieTypes.NOW_PLAYING)
        if movies.count == 0 {
            service.fetchNowPlayingData(successHandler: { [weak self] (data) -> (Void) in

                DataLayer.persistentContainer.performBackgroundTask { (context) in
                    
                    context.mergePolicy = NSMergePolicy.init(merge: .mergeByPropertyObjectTrumpMergePolicyType)
                    let response : NowPlayingResponse? = self?.translator.getUnsavedCoreDataObject(type: NowPlayingResponse.self, data: data, context: context)
                    response?.results.forEach {
                        $0.type = Int64.init(truncatingIfNeeded: MovieTypes.NOW_PLAYING.rawValue)
                    }
                    
                    DataLayer.saveContext(context: context)
                    
                }
                
                if let movies = self?.repository.fetchMovies(withType: MovieTypes.NOW_PLAYING){
                    handler(movies)
                }
                
            }) { (error) -> (Void) in
                debugPrint("Error while fetching Now Playing movies >>>------>", error.localizedDescription)
                handler([])
            }
        }
        handler(movies)
    }
}
