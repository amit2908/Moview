//
//  OtherMoviesDataSource.swift
//  Moview
//
//  Created by Empower on 22/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import CoreData

class OtherMoviesDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let presenter : OtherMoviesCollectionPresenter
//    final var collectionOfCollectionOfMovies : [[Movie]]
    final var sections : [String]
    final var vc : UIViewController
    
    init(presenter: OtherMoviesCollectionPresenter, sections: [String], vc: UIViewController) {
        self.presenter = presenter
//        self.collectionOfCollectionOfMovies = collectionOfCollectionOfMovies
        self.sections = sections
        self.vc = vc
        super.init()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.otherMoviesCollections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as? SectionHeader{
            sectionHeader.sectionHeaderLabel.text = self.sections[indexPath.section]
            return sectionHeader
        }
        return SectionHeader()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherCellIdentifier", for: indexPath)
        guard let otherMovieCell = cell as? OtherMovieCollectionViewCell else {
            let newCell = OtherMovieCollectionViewCell.init()
            return newCell
        }
        otherMovieCell.backgroundColor = UIColor.init(red: CGFloat(indexPath.row/5), green: CGFloat(indexPath.row/5), blue: CGFloat(indexPath.row/5), alpha: 1)
        return otherMovieCell
        
    }
    
    
}
extension OtherMoviesDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
}
