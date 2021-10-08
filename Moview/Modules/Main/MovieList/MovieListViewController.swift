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
    
    
    static let TOP_RATED        =   MovieTypes(rawValue: 1 << 0)
    static let UPCOMING         =   MovieTypes(rawValue: 1 << 1)
    static let FAVOURITES       =   MovieTypes(rawValue: 1 << 2)
    static let ACTION           =   MovieTypes(rawValue: 1 << 3)
    static let ROMANTIC         =   MovieTypes(rawValue: 1 << 4)
    static let NOW_PLAYING      =   MovieTypes(rawValue: 1 << 5)
    static let LATEST           =   MovieTypes(rawValue: 1 << 6)
    static let UNCATEGORISED    =   MovieTypes(rawValue: 1 << 7)
    static let ALL              =   [MovieTypes.TOP_RATED, .LATEST, .FAVOURITES, .ACTION, .ROMANTIC, .NOW_PLAYING , .UPCOMING]
    
    func getTitle() -> String {
        switch self {
        case .TOP_RATED:
            return "Top Rated Movies"
        case .LATEST:
            return "Latest Movies"
        case .UPCOMING:
            return "Upcoming Movies"
            
        default:
            return ""
        }
    }
}

final class MovieListViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var navBar: CustomNavigationBar!
    
    
    var dataSource : MovieListDataSource?
    var typeOfMovies : MovieTypes?
    var movies = [IMovie]()
    var movieListViewModel : MovieListViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListViewModel = MovieListViewModel(movies: movies)
        
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
        
    }
    
    fileprivate func setupCollectionDataSource() {
        self.dataSource = MovieListDataSource(movieListViewModel: movieListViewModel, vc: self)
        
        self.collectionView.dataSource = dataSource
        self.collectionView.delegate   = dataSource
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
