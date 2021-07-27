//
//  Repository.swift
//  Moview
//
//  Created by Shubham Ojha on 25/07/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import Foundation
import CoreData

protocol IMovieRepository {
    func storeMovie(movie: IMovie)
    func fetchMovie(using id: Int) -> IMovie?
    func bookmarkMovie(with id: Int)
}

extension IMovieRepository {
    func fetchNowPlayingMovies()    -> [IMovie] { return [] }
    func fetchUpcomingMovies()      -> [IMovie] { return [] }
    func fetchLatest()              -> [IMovie] { return [] }
    func fetchTopRates()            -> [IMovie] { return [] }
    func fetchFavouriteMovies()     -> [IMovie] { return [] }
    func fetchMostWatchedMovies()   -> [IMovie] { return [] }
}

protocol IMovie {
    var id: Int { get set }
    var title: String { get set }
    var overview: String { get set }
    var imageLink: String { get set }
}


struct MovieRepository: IMovieRepository {
    
    struct Movie: IMovie {
        var id: Int
        
        var title: String
        
        var overview: String
        
        var imageLink: String
        
    }

    
    
    func storeMovie(movie: IMovie) {
        
    }
    
    func fetchMovie(using id: Int) -> IMovie? {
        let fetchRequest = NSFetchRequest<Moview.Movie>.init()
        fetchRequest.sortDescriptors = [.init(key: "title", ascending: true)];
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate.init(format: "id == %d", id)
        do {
            let fetchResults = try DataLayer.viewContext.fetch(fetchRequest)
            let coreDataMovie = (fetchResults.count > 0 ? fetchResults.first : nil)
            
            let movie : MovieRepository.Movie = Movie(id: id,
                                                      title: coreDataMovie?.title ?? "",
                                                      overview: coreDataMovie?.overview ?? "",
                                                      imageLink: coreDataMovie?.poster_path ?? "")
            
            return movie
        }catch {
            print(error)
        }
        return nil
    }
    
    func bookmarkMovie(with id: Int) {
        
    }
}


