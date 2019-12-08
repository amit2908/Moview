//
//  MovieDetailPresenter.swift
//  Moview
//
//  Created by Empower on 16/10/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

typealias FetchMovieDetailFromSourceCompletionHandler = (Source)->(Void)

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
    
    func loadMovieDetails(movieId: Int, handler: @escaping FetchMovieDetailFromSourceCompletionHandler) {
        modelLayer.loadMovieDetails(from: .local, movieId: movieId) { (movie, source, error) -> (Void) in
            if (error == nil) {
                self.posterImagePath = movie?.poster_path ?? ""
                self.title  = movie?.title ?? ""
                handler(.local)
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
