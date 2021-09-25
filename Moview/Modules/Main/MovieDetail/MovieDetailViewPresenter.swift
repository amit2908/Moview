//
//  MovieDetailPresenter.swift
//  Moview
//
//  Created by Empower on 16/10/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

protocol IMovieDetailViewPresenter {
    var posterImagePath : String { get set }
    var title       : String   { get set }
    var isBookmarked : Bool    { get set }
    func setFavourite(movieId: Int32, isFavourite: Bool)
    func loadMovieDetails(movieId: Int32, handler: @escaping (IMovie?)->Void)
}

class MovieDetailViewPresenter: IMovieDetailViewPresenter {
    
    //MARK: Public Properties
    var posterImagePath : String
    var title       : String
    var isBookmarked : Bool
    
    fileprivate var movieRepository: IMovieCoreDataRepository
    fileprivate var movieDetailService: IMovieDetailsService
    fileprivate var translator: ITranslationLayer
    
    init(movieRepository: IMovieCoreDataRepository,
         movieDetailService: IMovieDetailsService,
         translator: ITranslationLayer) {
        self.movieRepository = movieRepository
        self.movieDetailService = movieDetailService
        self.translator = translator
        self.posterImagePath = ""
        self.title       = ""
        self.isBookmarked = false
    }
    
    
}

extension MovieDetailViewPresenter {
    func setFavourite(movieId: Int32, isFavourite: Bool) {
        self.movieRepository.bookmarkMovie(with: movieId, bookmark: isFavourite)
    }
    
    
    func loadMovieDetails(movieId: Int32, handler: @escaping (IMovie?) -> Void) {
        
        if let movie = movieRepository.fetchMovie(using: movieId) {
            self.posterImagePath = movie.imageLink
            self.title  = movie.overview
            self.isBookmarked = movie.isBookmarked
            handler(movie)
        }else {
            movieDetailService.fetchMovieDetails(movieId: movieId, successHandler: {[weak self] (data) -> (Void) in
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
