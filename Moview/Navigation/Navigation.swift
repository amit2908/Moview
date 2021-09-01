//
//  Navigation.swift
//  Moview
//
//  Created by Empower on 22/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

struct Navigation {
    static let shared = Navigation()
    
    func navigateToMainContainer(navigationController: UINavigationController){
        let mainContainer = MainContainerViewController(nibName: nil, bundle: nil)
        navigationController.viewControllers = [mainContainer]
        self.makeWindowKeyAndVisible()
    }
    
    func navigateToDashboard(navigationController: UINavigationController){
        let dashboardVC = UIStoryboard(name: Storyboards.shared.main, bundle: .main).instantiateViewController(withIdentifier: ViewControllers.shared.dashboard)
        navigationController.viewControllers = [dashboardVC]
        self.makeWindowKeyAndVisible()
    }
    
    func navigateToSignUp(navigationController: UINavigationController){
        let signUpVC = UIStoryboard(name: Storyboards.shared.signedOut, bundle: .main).instantiateViewController(withIdentifier: ViewControllers.shared.signUp)
        navigationController.pushViewController(signUpVC, animated: true)
    }
    
    func navigateToSignIn(navigationController: UINavigationController){
        let signInVC = UIStoryboard(name: Storyboards.shared.signedOut, bundle: .main).instantiateViewController(withIdentifier: ViewControllers.shared.signIn)
        navigationController.viewControllers = [signInVC]
        self.makeWindowKeyAndVisible()
    }
    
    func navigateToMovieDetail(movieId: Int32){
        let movieDetail = UIStoryboard(name: Storyboards.shared.main, bundle: .main).instantiateViewController(withIdentifier: ViewControllers.shared.movieDetail) as! MovieDetailViewController
        movieDetail.movieId = movieId
        UIApplication.currentViewController()?.navigationController?.pushViewController(movieDetail, animated: true)
    }
    
    func navigateToMovieList(navigationController: UINavigationController, movieTypes: MovieTypes, movies: [Movie]? = [Movie]()){
        let movieListVC = UIStoryboard(name: Storyboards.shared.main, bundle: .main).instantiateViewController(withIdentifier: ViewControllers.shared.movieList) as! MovieListViewController
        movieListVC.typeOfMovies             = movieTypes
        movieListVC.movies                   = movies ?? [Movie]()
        navigationController.show(movieListVC, sender: nil)
        self.makeWindowKeyAndVisible()
    }
    
    func navigateToFavouritesList(navigationController: UINavigationController, movieTypes: MovieTypes, movies: [Movie]? = [Movie]()){
        let movieListVC = UIStoryboard(name: Storyboards.shared.main, bundle: .main).instantiateViewController(withIdentifier: ViewControllers.shared.favourites) as! FavouriteMoviesViewController
//        movieListVC.movies                   = movies ?? [Movie]()
        navigationController.show(movieListVC, sender: nil)
//        self.makeWindowKeyAndVisible()
    }
    
}
extension Navigation {
    private func makeWindowKeyAndVisible() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.makeKeyAndVisible()
    }
}
