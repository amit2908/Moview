//
//  MovieListViewModel.swift
//  Moview
//
//  Created by Shubham Ojha on 27/03/20.
//  Copyright © 2020 Shubham. All rights reserved.
//

import Foundation

typealias FetchMovieCompletionHandler = () -> (Void)

final class MovieListViewModel : NSObject {
    var movies : Array<IMovie>
    
    init(movies: Array<IMovie>) {
        self.movies = movies
        super.init()
    }
    
    func loadMovies(completionHandler: FetchMovieCompletionHandler){
        
    }
}
