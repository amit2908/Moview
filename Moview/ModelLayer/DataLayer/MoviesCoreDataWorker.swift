//
//  MoviesCoreDataWorker.swift
//  Moview
//
//  Created by Shubham Ojha on 17/07/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import Foundation
import CoreData

typealias fetchMovieHandler = ([Movie]) -> (Void)
typealias fetchMovieDetailHandler = (Movie?) -> (Void)



protocol IMoviesCoreDataWorker {
    func fetchNowPlayingMoviesFromLocalDB(handler: fetchMovieHandler)
    func fetchUpcomingMoviesFromLocalDB(handler: fetchMovieHandler)
    func fetchTopRatedMoviesFromLocalDB(handler: fetchMovieHandler)
    func fetchLatestMoviesFromLocalDB(handler: fetchMovieHandler)
    func fetchMovieDetailFromLocalDB(movieId: Int32, handler: fetchMovieDetailHandler)
}

struct MoviesCoreDataWorker: IMoviesCoreDataWorker {
    
    func fetchNowPlayingMoviesFromLocalDB(handler: fetchMovieHandler){
        let fetchRequest = NSFetchRequest<Movie>.init(entityName: "Movie")
        fetchRequest.sortDescriptors = [.init(key: "title", ascending: true)];
        fetchRequest.fetchLimit = 10
        fetchRequest.predicate = NSPredicate(format: "isNowPlaying == true")
        do {
            let fetchResults = try DataLayer.viewContext.fetch(fetchRequest)
            handler(fetchResults)
        }catch {
            print(error)
            handler([Movie]())
        }
    }
    
    
    func fetchUpcomingMoviesFromLocalDB(handler: fetchMovieHandler){
        let fetchRequest = NSFetchRequest<Movie>.init(entityName: "Movie")
        fetchRequest.sortDescriptors = [.init(key: "title", ascending: true)];
        fetchRequest.fetchLimit = 10
        fetchRequest.predicate = NSPredicate(format: "isUpcoming == true")
        do {
            let fetchResults = try DataLayer.viewContext.fetch(fetchRequest)
            handler(fetchResults)
        }catch {
            print(error)
            handler([Movie]())
        }
    }
    
    func fetchTopRatedMoviesFromLocalDB(handler: fetchMovieHandler){
        let fetchRequest = NSFetchRequest<Movie>.init(entityName: "Movie")
        fetchRequest.sortDescriptors = [.init(key: "title", ascending: true)];
        fetchRequest.fetchLimit = 10
        fetchRequest.predicate = NSPredicate(format: "isTopRated == true")
        do {
            let fetchResults = try DataLayer.viewContext.fetch(fetchRequest)
            handler(fetchResults)
        }catch {
            print(error)
            handler([Movie]())
        }
    }
    
    func fetchLatestMoviesFromLocalDB(handler: fetchMovieHandler){
        let fetchRequest = NSFetchRequest<Movie>.init(entityName: "Movie")
        fetchRequest.sortDescriptors = [.init(key: "title", ascending: true)];
        fetchRequest.fetchLimit = 10
        fetchRequest.predicate = NSPredicate(format: "isLatest == true")
        do {
            let fetchResults = try DataLayer.viewContext.fetch(fetchRequest)
            handler(fetchResults)
        }catch {
            print(error)
            handler([Movie]())
        }
    }
    
    
    func fetchMovieDetailFromLocalDB(movieId: Int32, handler: fetchMovieDetailHandler){
        let fetchRequest = NSFetchRequest<Movie>.init(entityName: "Movie")
        fetchRequest.sortDescriptors = [.init(key: "title", ascending: true)];
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate.init(format: "id == %d", movieId)
        do {
            let fetchResults = try DataLayer.viewContext.fetch(fetchRequest)
            handler(fetchResults.count > 0 ? fetchResults[0] : nil)
        }catch {
            print(error)
            handler(nil)
        }
    }
    
    
}
