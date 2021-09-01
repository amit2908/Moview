//
//  DataLayer.swift
//  Moview
//
//  Created by Shubham Ojha on 22/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import CoreData

protocol IDataLayer {
    static var persistentContainer: NSPersistentContainer { get }
    static var viewContext: NSManagedObjectContext { get }
    static var backgroundContext: NSManagedObjectContext { get }
    static func saveContext(context: NSManagedObjectContext)
    static func clearOldResults(entityName: String)
}

class DataLayer: NSObject, IDataLayer {
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print("Store Description: =================>", storeDescription)
            
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
    
    static var backgroundContext = { () -> NSManagedObjectContext in
        let bgContext = DataLayer.persistentContainer.newBackgroundContext()
        return bgContext
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
    
    //MARK: - HELPER METHODS
    
    static func clearOldResults(entityName: String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: viewContext)
        }catch let error {
            print("Detele all data in \(entityName) error :", error)
        }
    }
}

extension DataLayer {
    //MARK: FIND OR CREATE ALGORITHM
    
   static func fetchMovie<T: NSFetchRequestResult>(with identifier: Int32,
                                                   entityName: String,
                                                     in context: NSManagedObjectContext) -> T? {
        let fetchRequest : NSFetchRequest<T> = NSFetchRequest<T>.init(entityName: entityName)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "%K == %d","id", identifier)
        
        if let objects = try? context.fetch(fetchRequest) {
            let object = objects.last
            return object
        }
        return nil
    }
    
}


extension DataLayer {
    
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
