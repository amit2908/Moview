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
    func fetchMovie(using id: Int32) -> IMovie?
    func bookmarkMovie(with id: Int32, bookmark: Bool)
    func fetchFavouriteMovies()     -> [IMovie]
}

extension IMovieRepository {
    func fetchNowPlayingMovies()    -> [IMovie] { return [] }
    func fetchUpcomingMovies()      -> [IMovie] { return [] }
    func fetchLatest()              -> [IMovie] { return [] }
    func fetchTopRates()            -> [IMovie] { return [] }
    func fetchFavouriteMovies()     -> [IMovie] {
        return []
    }
    func fetchMostWatchedMovies()   -> [IMovie] { return [] }
}

protocol IMovie {
    var id: Int { get set }
    var title: String { get set }
    var overview: String { get set }
    var imageLink: String { get set }
    var isBookmarked: Bool { get set }
}

struct NMovie: IMovie {
    var id: Int
    var title: String
    var overview: String
    var imageLink: String
    var isBookmarked: Bool
    
    init(movie: Movie){
        self.id = Int(movie.id)
        self.title = movie.title ?? ""
        self.overview = movie.overview ?? ""
        self.imageLink = movie.poster_path ?? ""
        self.isBookmarked = movie.isFavourite
    }
    
}


struct MovieRepository: IMovieRepository {
    
    static let shared = MovieRepository()
    
    private init() { }
    
    func storeMovie(movie: IMovie) {
        let bgContext = DataLayer.backgroundContext
        let cdMovie = Movie.init(context: bgContext)
        cdMovie.id = Int32(movie.id)
        cdMovie.title = movie.title
        cdMovie.overview = movie.overview
        cdMovie.poster_path = movie.imageLink
        
        DataLayer.saveContext(context: bgContext)
    }
    
    func fetchMovie(using id: Int32) -> IMovie? {
        let cdMovie: Movie? = DataLayer.fetchMovie(with: id, entityName: "Movie", in: DataLayer.viewContext)
        
        if let cdMovie = cdMovie {
            let movie : NMovie = NMovie(movie: cdMovie)
            return movie
        }
        
        return nil
    }
    
    func bookmarkMovie(with id: Int32, bookmark: Bool) {
        let bgContext = DataLayer.backgroundContext
        let cdMovie: Movie? = DataLayer.fetchMovie(with: id, entityName: "Movie", in: bgContext)
        
        if let cdMovie = cdMovie {
            cdMovie.isFavourite = bookmark
        }
        
        DataLayer.saveContext(context: bgContext)
    }
}


extension MovieRepository {
    func fetchFavouriteMovies()  -> [IMovie] {
        let fetchRequest: NSFetchRequest = Movie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isFavourite == %@", NSNumber.init(value: true))
        
        do {
            let cdMovies = try DataLayer.viewContext.fetch(fetchRequest)
            let nMovies = cdMovies.map{ NMovie(movie: $0) }
            return nMovies
        }
        catch {
            print(error)
        }
        
        return []
    }
}
