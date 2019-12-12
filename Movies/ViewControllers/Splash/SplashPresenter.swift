//
//  SplashPresenter.swift
//  Movies
//
//  Created by Sergey Krasiuk on 11/12/2019.
//  Copyright © 2019 Sergey Krasiuk. All rights reserved.
//

import Foundation

class SplashPresenter: SplashPresenterProtocol {
    
    weak var view: SplashViewProtocol?
    
    init(`for` view: SplashViewProtocol) {
        self.view = view
        
        self.requestData()
    }
    
    // MARK: - SplashPresenterProtocol
}

private extension SplashPresenter {
    
    func requestData() {
        
        if !CoreDataManager.isContextExists {
            WebServiceManager.shared.fetch(fromWebService: .movies, withParameters: [:]) { (error) in
                
                DispatchQueue.main.async {
                    if let errorRequest = error {
                        return
                    }
                    
                    self.view?.showMoviesListController()
                }
            }
            
            return
        }
        
        self.view?.showMoviesListController()
    }
}
