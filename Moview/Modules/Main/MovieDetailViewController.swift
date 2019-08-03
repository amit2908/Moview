//
//  MovieDetailViewController.swift
//  Moview
//
//  Created by Empower on 03/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    //MARK: Private Properties
    private let movie : Movie
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
