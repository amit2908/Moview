//
//  MovieDetailViewController.swift
//  Moview
//
//  Created by Empower on 12/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import CoreData


class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var navBar: CustomNavigationBar!
    @IBOutlet weak var imgV_moviePoster: UIImageView!
    @IBOutlet weak var tv_movieDetails: UITableView!
    
    var movieId : Int?

    var presenter : MovieDetailViewPresenter?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let networkLayer     = NetworkLayer()
        let dataLayer        = DataLayer()
        let translationLayer = TranslationLayer()
        let modelLayer       = ModelLayer(networkLayer: networkLayer, dataLayer: dataLayer, translationLayer: translationLayer)
        self.presenter       = MovieDetailViewPresenter(modelLayer: modelLayer)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        let networkLayer     = NetworkLayer()
        let dataLayer        = DataLayer()
        let translationLayer = TranslationLayer()
        let modelLayer       = ModelLayer(networkLayer: networkLayer, dataLayer: dataLayer, translationLayer: translationLayer)
        self.presenter       = MovieDetailViewPresenter(modelLayer: modelLayer)
        
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        print("MOVIE ID: \(movieId!)")
//        self.setupView()
//        self.fetchMovieDetails()
        self.loadData()
        self.customizeNavigationBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func customizeNavigationBar() {
        self.navBar.leftItem.isHidden = false
        self.navBar.btn_left.isHidden = false
        self.navBar.btn_left.addTarget(self, action: #selector(self.backButtonAction(sender:)), for: .touchUpInside)
        self.navBar.btn_left.setImage(UIImage(named: "back-button"), for: .normal);
    }
    
    func loadData(){
        self.presenter?.loadMovieDetails(movieId: self.movieId!) { [unowned self] (movie) -> (Void) in
            print(movie)
            DispatchQueue.main.async {
                self.navBar.title = self.presenter?.title ?? ""
                if let posterImgPath = self.presenter?.posterImagePath {
                    let posterPath =  K.Server.imageBaseURL + "/w342/" + posterImgPath
                    self.imgV_moviePoster.downloaded(from: URL.init(string: posterPath) ?? URL.init(fileURLWithPath: "picture.png", isDirectory: false), contentMode: .top)
                }
            }
        }
    }
    
    private func fetchMovieDetails(){
        
        guard let movieId = self.movieId else { return }
        
        self.showProgress(status: "Please wait...")
        
        APIClient.shared.GET(entity: Movie.self, urlRequest: MovieEndpoint.movieDetails(movieId: String(movieId) ).urlRequest! , completionHandler: { (movieDetails) -> (Void) in
            
            DispatchQueue.main.async(execute: {
                self.hideProgress()
            })
            let fetchRequest = NSFetchRequest<Movie>.init(entityName: "Movie")
            fetchRequest.fetchLimit = 5
            fetchRequest.sortDescriptors?.append(NSSortDescriptor.init(key: "title", ascending: true))
            
            do {
                let fetchResults = try DataLayer.viewContext.fetch(fetchRequest)
//                self.nowPlayingMovies = fetchResults
                DispatchQueue.main.async(execute: {
//                    self.collection_recent.reloadData()
                })
            }catch {
                print(error)
            }
            
        }) { (error) -> (Void) in
            self.hideProgress()
            print("Error occured: \(error.localizedDescription)")
        }
    }

    
    

}
