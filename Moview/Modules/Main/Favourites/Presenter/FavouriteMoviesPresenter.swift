//
//  FavouriteMoviesPresenter.swift
//  Moview
//
//  Created by Shubham Ojha on 17/07/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import Foundation

protocol IFavouriteMoviesPresenter {
    func loadFavouriteMovies(handler: @escaping ([IMovie]) -> Void)
    func removeMovie(withId movieId: Int32)
}

class FavouriteMoviesPresenter{
    let movieRepository: IMovieCoreDataRepository
    
    init(movieRepository: IMovieCoreDataRepository) {
        self.movieRepository = movieRepository
    }
}

extension FavouriteMoviesPresenter: IFavouriteMoviesPresenter {
    
    func loadFavouriteMovies(handler: @escaping ([IMovie]) -> Void) {
        let movies = movieRepository.fetchFavouriteMovies()
        handler(movies)
    }
    
    func removeMovie(withId movieId: Int32) {
        movieRepository.bookmarkMovie(with: movieId, bookmark: false)
    }
    
}
