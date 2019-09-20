//
//  ModelLayer.swift
//  Moview
//
//  Created by Shubham Ojha on 03/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation

typealias MovieFetchHandlerWithSource = ([Movie], Source, Error?)->(Void)

enum Source: Int {
    case local = 1, network
}

class ModelLayer {
    
    //MARK: Private Properties
    private let networkLayer     : NetworkLayer
    private let dataLayer        : DataLayer
    private let translationLayer : TranslationLayer
    
    
    //MARK: Public Methods
    init(networkLayer: NetworkLayer, dataLayer: DataLayer, translationLayer: TranslationLayer) {
        self.dataLayer        = dataLayer
        self.networkLayer     = networkLayer
        self.translationLayer = translationLayer
    }
    
    func loadNowPlayingMovies(from source: Source,  handler : @escaping MovieFetchHandlerWithSource){
        if (source == .local) {
            self.dataLayer.fetchNowPlayingMoviesFromLocalDB { (movies) -> (Void) in
                handler(movies, .local, nil)
            }
        }else {//network
            
                self.networkLayer.fetchNowPlayingDataFromServer(successHandler: {[unowned self] (data) -> (Void) in
                
                //clear old results
                DataLayer.clearOldResults(entityName: "Movie")
                let _ = self.translationLayer.getUnsavedCoreDataObject(type: NowPlayingResponse.self, data: data, context: DataLayer.backgroundContext)
                
                //save data to local
                DataLayer.saveContext(context: DataLayer.backgroundContext)
                
                //fetch again
                self.dataLayer.fetchNowPlayingMoviesFromLocalDB(handler: { (movies) -> (Void) in
                    handler(movies, .network , nil)
                })
                
            }) { (error) -> (Void) in
                handler([], .network, error)
            }
        }
    }
}
