//
//  CollectionViewConfigurator.swift
//  Moview
//
//  Created by Shubham Ojha on 17/06/22.
//  Copyright © 2022 Shubham. All rights reserved.
//

import UIKit

protocol ICollectionViewConfigurator {
    var configuration: ICollectionViewConfiguration { get set }
}

protocol ICollectionViewConfiguration {
    var sectionConfigurations: [ICollectionViewSectionConfiguration] { get set }
}

protocol ICollectionViewSectionConfiguration {
    var itemConfigurations: [ICollectionItemConfiguration] { get set }
}

protocol ICollectionItemConfiguration {
    var width: CGFloat { get set }
    var height: CGFloat { get set }
    var cellIdentifier: String { get set }
    var data                    : Any?              { get set }
    var cellDidSelectCallback   : (IndexPath)->Void { get set }
}

class CollectionViewConfigurator: NSObject, ICollectionViewConfigurator, UICollectionViewDataSource {
    
    var configuration: ICollectionViewConfiguration
    
    init(configuration: ICollectionViewConfiguration){
        self.configuration = configuration
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return configuration.sectionConfigurations[section].itemConfigurations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemConfig = configuration.sectionConfigurations[indexPath.section].itemConfigurations[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemConfig.cellIdentifier, for: indexPath) as? GenericCollectionCell else { return UICollectionViewCell() }
        cell.configure(withData: itemConfig)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return configuration.sectionConfigurations.count
    }
    
    
}

extension CollectionViewConfigurator: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let itemConfig = configuration.sectionConfigurations[indexPath.section].itemConfigurations[indexPath.item]
        itemConfig.cellDidSelectCallback(indexPath)
    }
}

extension CollectionViewConfigurator: UICollectionViewDelegateFlowLayout {
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        guard let size: CGSize = cell?.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize) else
        {
            
            return CGSize(width:  SCREEN_WIDTH/4, height: collectionView.frame.size.height - 20.0)
            
        }
        return size;
        
//        return CGSize(width: SCREEN_WIDTH/4, height: SCREEN_WIDTH/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    */
}
