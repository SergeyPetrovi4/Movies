//
//  MoviesListPresenter.swift
//  Movies
//
//  Created by Sergey Krasiuk on 12/12/2019.
//  Copyright © 2019 Sergey Krasiuk. All rights reserved.
//

import Foundation

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
}
