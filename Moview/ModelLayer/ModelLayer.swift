//
//  ModelLayer.swift
//  Moview
//
//  Created by Shubham Ojha on 03/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation

typealias MovieFetchHandlerWithSource = ([Movie], Source)->(Void)

enum Source: Int {
    case local = 1, network
}

class ModelLayer {
    let networkLayer : NetworkLayer
    let dataLayer    : DataLayer
    
    init(networkLayer: NetworkLayer, dataLayer: DataLayer) {
        self.dataLayer      = dataLayer
        self.networkLayer   = networkLayer
    }
    
    func loadMovies(fromSource: Source,  handler : MovieFetchHandlerWithSource){
        
    }
}
