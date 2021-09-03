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


protocol ITopRatedMoviesService {
    
    func fetchTopRatedMovies(page: Int,
    successHandler: @escaping FetchDataFromNetworkSuccessHandler,
    failureHandler: @escaping FetchDataFromNetworkFailureHandler)
    
}

struct TopRatedMoviesService: ITopRatedMoviesService{
    
    let apiClient : APIClient
    
    func fetchTopRatedMovies(page: Int,
                                       successHandler: @escaping FetchDataFromNetworkSuccessHandler,
                                       failureHandler: @escaping FetchDataFromNetworkFailureHandler) {
        
        let urlRequest = MovieEndpoint.topRated(page: page).urlRequest!
        
        apiClient.GET(entity: MoviesResponse.self, urlRequest: urlRequest, completionHandler: { (nowPlayingResponseData) -> (Void) in
            
            successHandler(nowPlayingResponseData)
            
        }) { (error) -> (Void) in
            //                print("Error occured: \(errCode) \(errMsg)")
            failureHandler(error)
        }
        
    }
    
}




protocol ILatestMoviesService {
    func fetchLatestMovies(successHandler: @escaping FetchDataFromNetworkSuccessHandler,
                                    failureHandler: @escaping FetchDataFromNetworkFailureHandler)
}

struct LatestMoviesService: ILatestMoviesService {
    
    let apiClient : APIClient
    
    func fetchLatestMovies(successHandler: @escaping FetchDataFromNetworkSuccessHandler,
                                       failureHandler: @escaping FetchDataFromNetworkFailureHandler) {
        
        let urlRequest = MovieEndpoint.latest.urlRequest!
        
        apiClient.GET(entity: Movie.self, urlRequest: urlRequest, completionHandler: { (nowPlayingResponseData) -> (Void) in
            
            successHandler(nowPlayingResponseData)
            
        }) { (error) -> (Void) in
            //                print("Error occured: \(errCode) \(errMsg)")
            failureHandler(error)
        }
        
    }
}


protocol IUpcomingMoviesService {
    func fetchUpcomingMovies(page: Int,
    successHandler: @escaping FetchDataFromNetworkSuccessHandler,
    failureHandler: @escaping FetchDataFromNetworkFailureHandler)
}

struct UpcomingMoviesService: IUpcomingMoviesService {
    
    let apiClient : APIClient
    
    func fetchUpcomingMovies(page: Int,
                                       successHandler: @escaping FetchDataFromNetworkSuccessHandler,
                                       failureHandler: @escaping FetchDataFromNetworkFailureHandler) {
        
        let urlRequest = MovieEndpoint.upcomingMovies(page: page).urlRequest!
        
        apiClient.GET(entity: MoviesResponse.self, urlRequest: urlRequest, completionHandler: { (nowPlayingResponseData) -> (Void) in
            
            successHandler(nowPlayingResponseData)
            
        }) { (error) -> (Void) in
            //                print("Error occured: \(errCode) \(errMsg)")
            failureHandler(error)
        }
        
    }
    
}


protocol IMovieDetailsService {
    func fetchMovieDetails(movieId: Int32,
    successHandler: @escaping FetchDataFromNetworkSuccessHandler,
    failureHandler: @escaping FetchDataFromNetworkFailureHandler)
}

struct MovieDetailsService: IMovieDetailsService {
    let apiClient: APIClient
    
    func fetchMovieDetails(movieId: Int32,
                                       successHandler: @escaping FetchDataFromNetworkSuccessHandler,
                                       failureHandler: @escaping FetchDataFromNetworkFailureHandler) {
        
        let urlRequest = MovieEndpoint.movieDetails(movieId: String(movieId)).urlRequest!
        
        apiClient.GET(entity: Movie.self, urlRequest: urlRequest, completionHandler: { (movieData) -> (Void) in
            
            successHandler(movieData)
            
        }) { (error) -> (Void) in
            //                print("Error occured: \(errCode) \(errMsg)")
            failureHandler(error)
        }
        
    }
}


protocol INowPlayingDataService {
    func fetchNowPlayingData(successHandler: @escaping FetchDataFromNetworkSuccessHandler,
    failureHandler: @escaping FetchDataFromNetworkFailureHandler)
}

struct NowPlayingDataService : INowPlayingDataService {
    
    let apiClient: APIClient
    
    func fetchNowPlayingData(successHandler: @escaping FetchDataFromNetworkSuccessHandler, failureHandler: @escaping FetchDataFromNetworkFailureHandler) {
        
        let urlRequest = MovieEndpoint.nowPlaying.urlRequest!
        
        apiClient.GET(entity: MoviesResponse.self, urlRequest: urlRequest, completionHandler: { (responseData) -> (Void) in
            
            successHandler(responseData)
            
        }) { (error) -> (Void) in
            failureHandler(error)
        }
        
    }
    
    
}
