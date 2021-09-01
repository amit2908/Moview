//
//  MovieDetailViewController.swift
//  Moview
//
//  Created by Empower on 12/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var navBar: CustomNavigationBar!
    @IBOutlet weak var imgV_moviePoster: UIImageView!
    @IBOutlet weak var tv_movieDetails: UITableView!
    
    var isFavourite: Bool = false {
        didSet {
            setFavourite()
        }
    }
    
    var movieId : Int32?

    var presenter : IMovieDetailViewPresenter!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupArchitecture()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupArchitecture()
    }
    
    func setupArchitecture(){
        self.presenter       = MovieDetailViewPresenter(movieRepository: MovieRepository.shared, movieDetailService: MovieDetailsService(), translator: TranslationLayer())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
        self.customizeNavigationBar()
    }
    
    private func customizeNavigationBar() {
        self.navBar.leftItem.isHidden = false
        self.navBar.btn_left.isHidden = false
        self.navBar.rightItem.isHidden = false
        self.navBar.btn_right.isHidden = false
        self.navBar.btn_left.addTarget(self, action: #selector(self.backButtonAction(sender:)), for: .touchUpInside)
        self.navBar.btn_left.setImage(UIImage(named: "back-button"), for: .normal);
        
        self.navBar.btn_right.addTarget(self, action: #selector(self.favouriteButtonTapped), for: .touchUpInside)
        
        self.navBar.btn_right.setImage(UIImage(named: "favourite-unselected")!, for: .normal)
    }
    
    func loadData(){
        self.presenter.loadMovieDetails(movieId: self.movieId!) { [unowned self] (movie) -> (Void) in
            if let movie = movie {
                DispatchQueue.main.async {
                    let posterPath =  K.Server.imageBaseURL + "/\(ImageSize.xLarge)/" + (movie.imageLink)
                    self.imgV_moviePoster.sd_setImage(with: URL.init(string: posterPath) ?? URL.init(fileURLWithPath: "picture.png", isDirectory: false), completed: nil)
                        self.imgV_moviePoster.downloaded(from: URL.init(string: posterPath) ?? URL.init(fileURLWithPath: "picture.png", isDirectory: false), contentMode: .top)
                }
            }
        }
    }

    
    @objc private func favouriteButtonTapped(){
        isFavourite.toggle()
    }
    
    private func setFavourite(){
        setNavBarFavouriteButton()
        presenter.setFavourite(movieId: self.movieId!, isFavourite: isFavourite)
    }

    private func setNavBarFavouriteButton(){
        if isFavourite {
            self.navBar.btn_right.setImage(UIImage(named: "favourite-selected")!, for: .normal)
        }else {
            self.navBar.btn_right.setImage(UIImage(named: "favourite-unselected")!, for: .normal)
        }
    }
}
