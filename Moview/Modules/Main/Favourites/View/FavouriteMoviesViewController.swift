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
    
    lazy var customAnimatedTransitioningDelegate: UIViewControllerTransitioningDelegate = {
        return ModalTransitioningDelegate(withTransition: FadeModalTransition())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FavouriteMovieTableCell.nib, forCellReuseIdentifier: FavouriteMovieTableCell.reuseID)
        self.title = "My Favourites"
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }
    
    private func configure(){
        presenter = FavouriteMoviesPresenter(movieRepository: MovieRepository.shared)
    }
    
    private func fetchMovies(){
        self.presenter?.loadFavouriteMovies(handler: { [weak self] (movies) -> (Void) in
            
            let tableConfiguration = FavouritesListConfiguration(movies: movies, cellDidSelectCallback: { indexPath in
                guard let movieDetailVC = self?.getMovieDetailVC(movies: movies, indexPath: indexPath) else { return }
                self?.present(movieDetailVC, animated: true, completion: {})
            }, leftSwipeCallback: { indexpath in
                self?.handleLeftSwipe(indexPath: indexpath, movies: movies)
            })
            
            self?.delegate = SwipableTableViewConfigurator(tableConfiguration: tableConfiguration)
            self?.tableView.dataSource = self?.delegate
            self?.tableView.delegate = self?.delegate
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    
    private func handleLeftSwipe(indexPath: IndexPath, movies: [IMovie]){
        self.presenter?.removeMovie(withId: Int32(movies[indexPath.row].id))
        self.fetchMovies()
        self.tableView.reloadData()
    }
    
    private func getMovieDetailVC(movies: [IMovie], indexPath: IndexPath) -> MovieDetailViewController {
        let movieDetailVC = UIStoryboard(name: Storyboards.shared.main, bundle: .main).instantiateViewController(withIdentifier: ViewControllers.shared.movieDetail) as! MovieDetailViewController
        movieDetailVC.modalPresentationStyle = .fullScreen
        movieDetailVC.transitioningDelegate = self.customAnimatedTransitioningDelegate
        movieDetailVC.movieId = Int32(movies[indexPath.row].id)
        movieDetailVC.onBackButtonPress = {
            movieDetailVC.dismiss(animated: true, completion: nil)
        }
        return movieDetailVC
    }

}
