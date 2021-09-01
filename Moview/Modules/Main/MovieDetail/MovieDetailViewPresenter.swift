//
//  MovieDetailPresenter.swift
//  Moview
//
//  Created by Empower on 16/10/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

typealias FetchMovieDetailFromSourceCompletionHandler = (Source, Movie?)->(Void)

protocol IMovieDetailViewPresenter {
    func setFavourite(movieId: Int32, isFavourite: Bool)
    func loadMovieDetails(movieId: Int32, handler: @escaping (IMovie?)->Void)
}

class MovieDetailViewPresenter {
    
    //MARK: Public Properties
    var posterImagePath : String
    var title       : String
    
    fileprivate var movieRepository: IMovieRepository
    fileprivate var movieDetailService: IMovieDetailsService
    fileprivate var translator: ITranslationLayer
    
    init(movieRepository: IMovieRepository,
         movieDetailService: IMovieDetailsService,
         translator: ITranslationLayer) {
        self.movieRepository = movieRepository
        self.movieDetailService = movieDetailService
        self.translator = translator
        self.posterImagePath = ""
        self.title       = ""
    }
    
    
}

extension MovieDetailViewPresenter: IMovieDetailViewPresenter{
    func setFavourite(movieId: Int32, isFavourite: Bool) {
        self.movieRepository.bookmarkMovie(with: movieId, bookmark: isFavourite)
    }
    
    
    
    func loadMovieDetails(movieId: Int32, handler: @escaping (IMovie?) -> Void) {
        
        if let movie = movieRepository.fetchMovie(using: movieId) {
            self.posterImagePath = movie.imageLink
            self.title  = movie.title
            handler(movie)
        }else {
            movieDetailService.fetchMovieDetailsFromServer(movieId: movieId, successHandler: {[weak self] (data) -> (Void) in
                guard let cdMovie = self?.translator.getUnsavedCoreDataObject(type: Movie.self, data: data, context: DataLayer.viewContext) else { handler(nil); return }
                DataLayer.saveContext(context: DataLayer.viewContext)
                let nMovie = NMovie(movie: cdMovie)
                handler(nMovie)
                
            }) { (error) -> (Void) in
                print(error)
            }
        }
        
        
        
        
    }
}
