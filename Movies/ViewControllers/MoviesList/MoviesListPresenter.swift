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
}
