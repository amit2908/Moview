//
//  OtherMoviesDataSource.swift
//  Moview
//
//  Created by Empower on 22/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import CoreData

class OtherMoviesDataSource: NSObject {
    
    //MARK: Public Properties
//    let presenter : IOtherMoviesPresenter
    var otherMoviesViewModel : OtherMoviesCollectionViewModel
//    final var collectionOfCollectionOfMovies : [[Movie]]
    final weak var vc : DashboardViewController?
    
    //MARK: Private Properties
    
    init(otherMoviesViewModel : OtherMoviesCollectionViewModel, vc: DashboardViewController) {
        self.otherMoviesViewModel = otherMoviesViewModel
        self.vc = vc
        super.init()
    }
    
}

extension OtherMoviesDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return otherMoviesViewModel.sections.count
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as? SectionHeader{
                sectionHeader.sectionHeaderLabel.text = otherMoviesViewModel.sections[indexPath.section]
                sectionHeader.btn_showMore.addTarget(vc, action: #selector(vc?.showMoreBtnClicked(button:)), for: .touchDown)
                sectionHeader.btn_showMore.tag = indexPath.section
                return sectionHeader
            }
            return SectionHeader()
        }
        
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    //        return CGSize(width: SCREEN_WIDTH, height: 60)
    //    }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherCellIdentifier", for: indexPath)
            
            guard let otherMovieCell = cell as? OtherMovieCollectionViewCell else {
                let newCell = OtherMovieCollectionViewCell.init()
                return newCell
            }
            
            otherMovieCell.backgroundColor = UIColor.init(red: CGFloat(indexPath.row/5), green: CGFloat(indexPath.row/5), blue: CGFloat(indexPath.row/5), alpha: 1)
            
            otherMovieCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self.otherMoviesViewModel.dataSources[indexPath.section], forRow: indexPath.section)
            
            return otherMovieCell
            
        }
        
        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            
        }
}

extension OtherMoviesDataSource: UICollectionViewDelegate {
    
}

extension OtherMoviesDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
}
