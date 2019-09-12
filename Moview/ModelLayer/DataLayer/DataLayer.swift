//
//  DataLayer.swift
//  Moview
//
//  Created by Shubham Ojha on 22/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import CoreData

class DataLayer: NSObject {
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print(storeDescription)
            
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static var viewContext = {
        return DataLayer.persistentContainer.viewContext
    }()
    
    static var backgroundContext = {
        return DataLayer.persistentContainer.newBackgroundContext()
    }()
    
    // MARK: - Core Data Saving support
    
    static func saveContext (context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension DataLayer {
    //MARK: FIND OR CREATE ALGORITHM
    
    func findObject<T: NSFetchRequestResult>(entity: T,
                                                     entityName: String,
                                                     with identifier: String,
                                                     in context: NSManagedObjectContext) -> T? {
        let fetchRequest : NSFetchRequest<T> = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "%K == %@","id", identifier)
        
        if let objects = try? context.fetch(fetchRequest) {
            let object = objects.last
            return object!
        }
        return nil
    }
    
}

typealias fetchMovieHandler = ([Movie]) -> (Void)

extension DataLayer {
    
    
    private func fetchNowPlayingMoviesFromLocalDB(handler: fetchMovieHandler){
        let fetchRequest = NSFetchRequest<Movie>.init(entityName: "Movie")
        fetchRequest.fetchLimit = 3
        do {
            let fetchResults = try DataLayer.backgroundContext.fetch(fetchRequest)
            handler(fetchResults)
//            self.nowPlayingMovies = fetchResults
//            self.otherMovieDataSource = OtherMoviesDataSource(movies: self.nowPlayingMovies ,sections: self.sections, vc: self)
//            self.recentMovieDataSource = RecentMoviesDataSource(movies: self.nowPlayingMovies, collectionView: self.collection_recent)
//            DispatchQueue.main.async(execute: {
//                self.collection_other.delegate = self.otherMovieDataSource
//                self.collection_other.dataSource = self.otherMovieDataSource
//                self.collection_recent.delegate = self.recentMovieDataSource
//                self.collection_recent.dataSource = self.recentMovieDataSource
//                self.collection_recent.reloadData()
//                self.collection_other.reloadData()
//            })
        }catch {
            print(error)
        }
        
    }
}