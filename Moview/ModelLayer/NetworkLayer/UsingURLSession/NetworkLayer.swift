//
//  NetworkLayer.swift
//  Moview
//
//  Created by Shubham Ojha on 03/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation

typealias FetchDataFromNetworkSuccessHandler = (Data)->(Void)
typealias FetchDataFromNetworkFailureHandler = (Error)->(Void)


protocol INetworkLayer {
    func fetchNowPlayingDataFromServer(successHandler: @escaping FetchDataFromNetworkSuccessHandler,
    failureHandler: @escaping FetchDataFromNetworkFailureHandler)
    
    
    func fetchUpcomingMoviesFromServer(page: Int,
    successHandler: @escaping FetchDataFromNetworkSuccessHandler,
    failureHandler: @escaping FetchDataFromNetworkFailureHandler)
    
    
    func fetchTopRatedMoviesFromServer(page: Int,
    successHandler: @escaping FetchDataFromNetworkSuccessHandler,
    failureHandler: @escaping FetchDataFromNetworkFailureHandler)
    
    
    func fetchMovieDetailsFromServer(movieId: Int32,
    successHandler: @escaping FetchDataFromNetworkSuccessHandler,
    failureHandler: @escaping FetchDataFromNetworkFailureHandler)
}

class NetworkLayer: INetworkLayer {
    
    func fetchNowPlayingDataFromServer(successHandler: @escaping FetchDataFromNetworkSuccessHandler,
                                       failureHandler: @escaping FetchDataFromNetworkFailureHandler) {
        
        let urlRequest = MovieEndpoint.nowPlaying.urlRequest!
        
        APIClient.shared.GET(entity: NowPlayingResponse.self, urlRequest: urlRequest, completionHandler: { (nowPlayingResponseData) -> (Void) in
            
            successHandler(nowPlayingResponseData)
            
        }) { (error) -> (Void) in
            //                print("Error occured: \(errCode) \(errMsg)")
            failureHandler(error)
        }
        
    }
    
    
    func fetchUpcomingMoviesFromServer(page: Int,
                                       successHandler: @escaping FetchDataFromNetworkSuccessHandler,
                                       failureHandler: @escaping FetchDataFromNetworkFailureHandler) {
        
        let urlRequest = MovieEndpoint.upcomingMovies(page: page).urlRequest!
        
        APIClient.shared.GET(entity: NowPlayingResponse.self, urlRequest: urlRequest, completionHandler: { (nowPlayingResponseData) -> (Void) in
            
            successHandler(nowPlayingResponseData)
            
        }) { (error) -> (Void) in
            //                print("Error occured: \(errCode) \(errMsg)")
            failureHandler(error)
        }
        
    }
    
    func fetchTopRatedMoviesFromServer(page: Int,
                                       successHandler: @escaping FetchDataFromNetworkSuccessHandler,
                                       failureHandler: @escaping FetchDataFromNetworkFailureHandler) {
        
        let urlRequest = MovieEndpoint.topRated(page: page).urlRequest!
        
        APIClient.shared.GET(entity: NowPlayingResponse.self, urlRequest: urlRequest, completionHandler: { (nowPlayingResponseData) -> (Void) in
            
            successHandler(nowPlayingResponseData)
            
        }) { (error) -> (Void) in
            //                print("Error occured: \(errCode) \(errMsg)")
            failureHandler(error)
        }
        
    }
    
    
    func fetchLatestMovieFromServer(successHandler: @escaping FetchDataFromNetworkSuccessHandler,
                                       failureHandler: @escaping FetchDataFromNetworkFailureHandler) {
        
        let urlRequest = MovieEndpoint.latest.urlRequest!
        
        APIClient.shared.GET(entity: Movie.self, urlRequest: urlRequest, completionHandler: { (nowPlayingResponseData) -> (Void) in
            
            successHandler(nowPlayingResponseData)
            
        }) { (error) -> (Void) in
            //                print("Error occured: \(errCode) \(errMsg)")
            failureHandler(error)
        }
        
    }
    
    
    func fetchMovieDetailsFromServer(movieId: Int32,
                                       successHandler: @escaping FetchDataFromNetworkSuccessHandler,
                                       failureHandler: @escaping FetchDataFromNetworkFailureHandler) {
        
        let urlRequest = MovieEndpoint.movieDetails(movieId: String(movieId)).urlRequest!
        
        APIClient.shared.GET(entity: Movie.self, urlRequest: urlRequest, completionHandler: { (movieData) -> (Void) in
            
            successHandler(movieData)
            
        }) { (error) -> (Void) in
            //                print("Error occured: \(errCode) \(errMsg)")
            failureHandler(error)
        }
        
    }
    
}


protocol IMovieDetailsService {
    func fetchMovieDetailsFromServer(movieId: Int32,
    successHandler: @escaping FetchDataFromNetworkSuccessHandler,
    failureHandler: @escaping FetchDataFromNetworkFailureHandler)
}

struct MovieDetailsService: IMovieDetailsService {
    func fetchMovieDetailsFromServer(movieId: Int32,
                                       successHandler: @escaping FetchDataFromNetworkSuccessHandler,
                                       failureHandler: @escaping FetchDataFromNetworkFailureHandler) {
        
        let urlRequest = MovieEndpoint.movieDetails(movieId: String(movieId)).urlRequest!
        
        APIClient.shared.GET(entity: Movie.self, urlRequest: urlRequest, completionHandler: { (movieData) -> (Void) in
            
            successHandler(movieData)
            
        }) { (error) -> (Void) in
            //                print("Error occured: \(errCode) \(errMsg)")
            failureHandler(error)
        }
        
    }
}
