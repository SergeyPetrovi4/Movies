//
//  SplashViewController.swift
//  Movies
//
//  Created by Sergey Krasiuk on 11/12/2019.
//  Copyright © 2019 Sergey Krasiuk. All rights reserved.
//

import UIKit
import RappleProgressHUD

class SplashViewController: UIViewController, SplashViewProtocol  {
    
    private var presenter: SplashPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RappleActivityIndicatorView.startAnimating()
        self.presenter = SplashPresenter(for: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.presenter.requestData()
    }
    
    // MARK: - SplashViewProtocol
    
    func showMoviesListController() {
        
        RappleActivityIndicatorView.stopAnimation()
        if let window = SceneDelegate.shared?.window {
            let navigationViewController = UINavigationController(rootViewController: MoviesListTableViewController.instantiate())
            window.rootViewController = navigationViewController
        }
    }
}
