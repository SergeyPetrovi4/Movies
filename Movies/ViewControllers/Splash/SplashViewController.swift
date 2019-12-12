//
//  SplashViewController.swift
//  Movies
//
//  Created by Sergey Krasiuk on 11/12/2019.
//  Copyright © 2019 Sergey Krasiuk. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController, SplashViewProtocol  {
    
    private var presenter: SplashPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = SplashPresenter(for: self)
    }
    
    // MARK: - UI
    
    // MARK: - Actions
    
    // MARK: - Private
    
    // MARK: - SplashViewProtocol
    
    func showMoviesListController() {
        
        if let window = SceneDelegate.shared?.window {
            window.rootViewController = MoviesListViewController.instantiate()
        }
    }
}
