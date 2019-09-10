//
//  ModelLayer.swift
//  Moview
//
//  Created by Shubham Ojha on 03/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation

typealias MovieFetchHandler = ([Movie])->(Void)

class ModelLayer {
    let networkLayer : NetworkLayer
    let dataLayer    : DataLayer
    
    init(networkLayer: NetworkLayer, dataLayer: DataLayer) {
        self.dataLayer      = dataLayer
        self.networkLayer   = networkLayer
    }
    
    func loadMovies(handler : MovieFetchHandler){
        
    }
}
