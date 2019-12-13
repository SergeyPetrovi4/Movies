//
//  MoviesListPresenter.swift
//  Movies
//
//  Created by Sergey Krasiuk on 12/12/2019.
//  Copyright © 2019 Sergey Krasiuk. All rights reserved.
//

import Foundation
import CoreData

class MoviesListPresenter: MoviesListPresenterProtocol {
    
    weak var view: MoviesListViewProtocol?
    
    init(`for` view: MoviesListViewProtocol) {
        self.view = view
    }
    
    // MARK: - Private
    
    // MARK: - MoviesListPresenterProtocol
    
    func fetchMovies() {
        
        guard let movies = try? CoreDataManager.shared.context.fetch(Movie.request()) else {
            self.view?.displayAlert(with: "Movies", message: "Error fetching data from local storage", actions: nil)
            return
        }
        
        self.view?.set(movies: movies.sorted(by: { $0.releaseYear > $1.releaseYear }))
    }
    
    func addMovie(from result: String) {
        
        if let data = result.data(using: .utf8) {
            
            do {
                
                let movie = try WebServiceManager.shared.decode(Movie.self, fromData: data)
                
                let request = NSFetchRequest<Movie>(entityName: "Movie")
                request.predicate = NSPredicate(format: "title == %@ AND releaseYear == %@", movie.title!, "\(movie.releaseYear)")
                                
                guard try CoreDataManager.shared.context.fetch(request).first == nil else {
                    self.view?.displayAlert(with: "Movie", message: "Current movie already exist in the Database", actions: nil)
                    return
                }
                
                CoreDataManager.shared.saveContext()
                self.fetchMovies()

            } catch let error {
                self.view?.displayAlert(with: "Movie", message: error.localizedDescription, actions: nil)
            }
        }
    }
}
