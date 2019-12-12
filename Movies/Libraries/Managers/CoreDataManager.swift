//
//  CoreDataManager.swift
//  Movies
//
//  Created by Sergey Krasiuk on 05/11/2019.
//  Copyright © 2019 Sergey Krasiuk. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
        
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    static var isContextExists: Bool {
        guard let movies = try? CoreDataManager.shared.context.fetch(Movie.request()), !movies.isEmpty else {
            return false
        }
        
        return true
    }
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Movies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        
        let context = self.persistentContainer.viewContext
        
        if context.hasChanges {
            
            do {
                try context.save()
                
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
//    func isContextExists() -> Bool {
//
//        guard let movies = try? CoreDataManager.shared.context.fetch(Movie.request()), !movies.isEmpty else {
//            return nil
//        }
//
//        return movies
//    }
}
