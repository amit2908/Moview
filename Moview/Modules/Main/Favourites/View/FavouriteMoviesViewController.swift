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
        fetchMovies()
    }
    
    private func configure(){
        presenter = FavouriteMoviesPresenter(movieRepository: MovieRepository.shared)
    }
    
    private func fetchMovies(){
        self.presenter?.loadFavouriteMovies(handler: { [weak self] (movies) -> (Void) in
            self?.delegate = TableViewConfigurator(tableConfiguration: FavouritesListConfiguration(movies: movies, cellDidSelectCallback: { indexPath in
        
                let movieDetailVC = UIStoryboard(name: Storyboards.shared.main, bundle: .main).instantiateViewController(withIdentifier: ViewControllers.shared.movieDetail) as! MovieDetailViewController
                movieDetailVC.modalPresentationStyle = .fullScreen
                movieDetailVC.transitioningDelegate = self?.customAnimatedTransitioningDelegate
                movieDetailVC.movieId = Int32(movies[indexPath.row].id)
                movieDetailVC.onBackButtonPress = {
                    movieDetailVC.dismiss(animated: true, completion: nil)
                }
                self?.present(movieDetailVC, animated: true, completion: {
                    
                })
//                UIApplication.currentViewController()?.navigationController?.pushViewController(movieDetailVC, animated: true)
                
            }))
            
            self?.tableView.dataSource = self?.delegate
            self?.tableView.delegate = self?.delegate
        })
    }

}
