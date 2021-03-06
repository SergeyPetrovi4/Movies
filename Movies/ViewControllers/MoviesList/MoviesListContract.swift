//
//  MoviesListContract.swift
//  Movies
//
//  Created by Sergey Krasiuk on 12/12/2019.
//  Copyright © 2019 Sergey Krasiuk. All rights reserved.
//

import Foundation

protocol MoviesListViewProtocol: class, AlertableView {
    
    func set(movies: [Movie])
    func select(movie: Movie)
}

protocol MoviesListPresenterProtocol {
    
    func fetchMovies()
    func addMovie(from result: String)
}
