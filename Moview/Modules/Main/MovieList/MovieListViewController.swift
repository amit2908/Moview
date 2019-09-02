//
//  MovieListViewController.swift
//  Moview
//
//  Created by Shubham Ojha on 02/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

struct MovieTypes: OptionSet {
    
    let rawValue: Int
    
    static let TOP_RATED        = MovieTypes(rawValue: 1 << 0)
    static let LATEST           = MovieTypes(rawValue: 1 << 1)
    static let FAVOURITES       = MovieTypes(rawValue: 1 << 2)
    static let ACTION           = MovieTypes(rawValue: 1 << 3)
    static let ROMANTIC         = MovieTypes(rawValue: 1 << 4)
    static let ALL              = [MovieTypes.TOP_RATED, .LATEST, .FAVOURITES, .ACTION, .ROMANTIC]
}

class MovieListViewController: UIViewController {

    final var dataSource : MovieListDataSource?
    final var typeOfMovies : MovieTypes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func fetchMovies(of types: MovieTypes) {
        
        
    }
    

}
