//
//  MoviesListViewController.swift
//  Movies
//
//  Created by Sergey Krasiuk on 12/12/2019.
//  Copyright © 2019 Sergey Krasiuk. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader

class MoviesListTableViewController: UITableViewController, MoviesListViewProtocol  {
    
    static func instantiate() -> MoviesListTableViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MoviesListTableViewController.self)) as! MoviesListTableViewController
    }
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = true
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    private var presenter: MoviesListPresenterProtocol!
    private var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = MoviesListPresenter(for: self)
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter.fetchMovies()
    }
    
    
    // MARK: - Actions
    
    @objc func didTapAddMovieBarButtonItem() {
        
        self.readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            
            if let resultScanning = result?.value {
                self.presenter.addMovie(from: resultScanning)
            }
            
            self.readerVC.stopScanning()
            self.readerVC.dismiss(animated: true, completion: nil)
        }

        self.readerVC.modalPresentationStyle = .formSheet
        present(self.readerVC, animated: true, completion: nil)
    }
    
    // MARK: - MoviesListViewProtocol
    
    func set(movies: [Movie]) {
        self.movies = movies
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieTableViewCell.self), for: indexPath) as! MovieTableViewCell
        cell.configure(with: self.movies[indexPath.row])
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "movieDetails" {
            if let movieDetailsViewController = segue.destination as? MovieDetailsViewController,
                let indexPath = self.tableView.indexPathForSelectedRow {
                movieDetailsViewController.movie = self.movies[indexPath.row]
            }
        }
    }
}

private extension MoviesListTableViewController {
    // MARK: - Private
    // MARK: - UI
    
    func setupUI() {
        
        self.title = "Movies"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableView.automaticDimension
        
        let addMovieBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                    target: self,
                                                    action: #selector(MoviesListTableViewController.didTapAddMovieBarButtonItem))
        self.navigationItem.rightBarButtonItem = addMovieBarButtonItem
    }
}
