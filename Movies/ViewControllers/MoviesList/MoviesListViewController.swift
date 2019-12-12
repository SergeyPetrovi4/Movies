//
//  MoviesListViewController.swift
//  Movies
//
//  Created by Sergey Krasiuk on 12/12/2019.
//  Copyright © 2019 Sergey Krasiuk. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController, MoviesListViewProtocol  {
    
    static func instantiate() -> MoviesListViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MoviesListViewController.self)) as! MoviesListViewController
    }
    
    private var presenter: MoviesListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = MoviesListPresenter(for: self)
    }
    
    // MARK: - UI
    
    // MARK: - Actions
    
    // MARK: - Private
    
    // MARK: - MoviesListViewProtocol
}
