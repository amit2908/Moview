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
    func setFavourite(movieId: Int, isFavourite: Bool)
    func loadMovieDetails(movieId: Int, handler: @escaping FetchMovieDetailFromSourceCompletionHandler)
}

class MovieDetailViewPresenter {
    
    //MARK: Public Properties
    var posterImagePath : String
    var title       : String
    
    fileprivate var modelLayer : ModelLayer
    
    init(modelLayer: ModelLayer) {
        self.modelLayer  = modelLayer
        self.posterImagePath = ""
        self.title       = ""
    }
    
    
}

extension MovieDetailViewPresenter: IMovieDetailViewPresenter{
    func setFavourite(movieId: Int, isFavourite: Bool) {
        self.modelLayer.loadMovieDetails(from: .local, movieId: movieId) { (movie, source, error) -> (Void) in
            if let mov = movie {
                mov.isFavourite = isFavourite
                try? mov.managedObjectContext?.save()
            }
        }
    }
    
    
    
    func loadMovieDetails(movieId: Int, handler: @escaping FetchMovieDetailFromSourceCompletionHandler) {
            modelLayer.loadMovieDetails(from: .local, movieId: movieId) { (movie, source, error) -> (Void) in
                if (error == nil) {
                    self.posterImagePath = movie?.poster_path ?? ""
                    self.title  = movie?.title ?? ""
                    handler(.local, movie)
                }
            }
            
    //        modelLayer.loadMovieDetails(from: .network, movieId: movieId) { (movie, source, error) -> (Void) in
    //            if (error == nil) {
    //                self.posterImage = UIImage(contentsOfFile: movie?.poster_path ?? "") ?? UIImage()
    //                self.title  = movie?.title ?? ""
    //                handler(.network)
    //            }
    //        }
            
        }
}
