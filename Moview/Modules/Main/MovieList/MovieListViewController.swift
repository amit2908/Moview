//
//  MovieListViewController.swift
//  Moview
//
//  Created by Shubham Ojha on 02/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

enum MovieTypes: Int {
    case NOW_PLAYING        =    0
    case UPCOMING           =    1
    case TOP_RATED          =    2
    case ACTION             =    3
    case ROMANTIC           =    4
    case FAVOURITES         =    5
    case LATEST             =    6
    case UNCATEGORISED      =    7
    
    func getTitle() -> String {
        switch self {
        case .TOP_RATED:
            return "Top Rated Movies"
        case .LATEST:
            return "Latest Movies"
        case .UPCOMING:
            return "Upcoming Movies"
        case .NOW_PLAYING:
            return "Now Playing Movies"
        default:
            return ""
        }
    }
}

final class MovieListViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var navBar: CustomNavigationBar!
    
    
    var dataSource : CollectionViewConfigurator?
    var typeOfMovies : MovieTypes?
    var movies = [IMovie]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionDataSource()
        setupView()
    }
    
    private func setupView(){
        self.navBar.top_Item.isHidden = false
        self.navBar.titleLabel.isHidden = false
        self.navBar.title = self.typeOfMovies?.getTitle()
        
        self.navBar.btn_left.isHidden = false
        self.navBar.btn_left.setImage(UIImage(named: "back-button"), for: .normal)
        self.navBar.btn_left.addTarget(self, action: #selector(self.backButtonAction(sender:)), for: .touchDown)
        self.collectionView.register(MovieListCollectionViewCell.nib, forCellWithReuseIdentifier: MovieListCollectionViewCell.reuseID)
    }
    
    fileprivate func setupCollectionDataSource() {
        let collectionConfiguration = MovieListViewConfiguration(movies: movies, cellDidSelectCallback: { [weak self] indexPath in
            self?.handleSelection(indexPath: indexPath)
        })
        self.dataSource = CollectionViewConfigurator(configuration: collectionConfiguration)
        self.collectionView.dataSource = dataSource
        self.collectionView.delegate   = dataSource
    }
    
    fileprivate func handleSelection(indexPath: IndexPath){
        let storyboard = UIStoryboard(name: Storyboards.shared.main, bundle: .main)
        let movieDetailVC = storyboard.instantiateViewController(withIdentifier: ViewControllers.shared.movieDetail) as? MovieDetailViewController
        movieDetailVC?.movieId = Int32(truncatingIfNeeded: self.movies[indexPath.item].id)
        movieDetailVC?.onBackButtonPress = {
            movieDetailVC?.navigationController?.popViewController(animated: true)
        }
        UIApplication.currentViewController()?.navigationController?.pushViewController(movieDetailVC!, animated: true)
    }
    
    
    private func fetchMovies(of types: MovieTypes) {
        
    }
    
    @objc func refresh() {
        
    }
    
    var movingIndexPath : IndexPath!
    
    func pickedUpCell () -> UICollectionViewCell? {
        let pickedUpCell = self.collectionView.cellForItem(at: movingIndexPath)
        return pickedUpCell
    }
    
    func longPressed(gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: self.collectionView)
        movingIndexPath = self.collectionView.indexPathForItem(at: location)
        
        switch(gesture.state) {
        case .began:
            guard let indexPath = movingIndexPath else { break }
            setEditing(true, animated: true)
            self.collectionView.beginInteractiveMovementForItem(at: indexPath)
            pickedUpCell()?.stopWiggling()
            //        animatePickingUpCell(pickedUpCell())
        case .changed:
            self.collectionView.updateInteractiveMovementTargetPosition(location)
        case .ended:
            self.collectionView.endInteractiveMovement()
            //        animatePuttingDownCell(pickedUpCell())
            movingIndexPath = nil
        default:
            self.collectionView.cancelInteractiveMovement()
            //        animatePuttingDownCell(pickedUpCell())
            movingIndexPath = nil
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        startWigglingAllVisibleCells()
    }
    
    func startWigglingAllVisibleCells(){
        _ = self.collectionView.visibleCells.map{ $0.startWiggling() }
    }
}
