//
//  FavouriteMoviesViewController.swift
//  Moview
//
//  Created by Shubham Ojha on 15/05/20.
//  Copyright © 2020 Shubham. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class FavouriteMoviesViewController: UIViewController {
    @IBOutlet var barItem: RAMAnimatedTabBarItem!
    @IBOutlet var tableView: UITableView!
    
    
    var presenter : IFavouriteMoviesPresenter?
    
    var delegate : TableViewConfigurator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FavouriteMovieTableCell.nib, forCellReuseIdentifier: FavouriteMovieTableCell.reuseID)
        self.title = "My Favourites"
        
        presenter = FavouriteMoviesPresenter(networkLayer: NetworkLayer(), coreDataWorker: MoviesCoreDataWorker(dataLayer: DataLayer()))
        fetchMovies()
    }
    
    private func fetchMovies(){
        self.presenter?.loadFavouriteMoviesFromLocal(handler: { [weak self] (movies) -> (Void) in
            self?.delegate = TableViewConfigurator(tableConfiguration: FavouritesListConfiguration(movies: movies))
            
            self?.tableView.dataSource = self?.delegate
            self?.tableView.delegate = self?.delegate
//            self?.tableView.reloadData()
        })
    }

}
