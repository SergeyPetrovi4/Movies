//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Sergey Krasiuk on 12/12/2019.
//  Copyright © 2019 Sergey Krasiuk. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    
    @IBOutlet weak var rating: SwiftyStarRatingView!
    @IBOutlet weak var genresLabel: UILabel!
    
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateUI()
    }
}

private extension MovieDetailsViewController {
    
    // MARK: - Private
    // MARK: - UI
    
    func updateUI() {
        
        guard let passedMovie = self.movie else {
            return
        }
        
        if let url = URL(string: passedMovie.image ?? "") {
            self.moviePosterImageView.kf.setImage(with: url)
        }
        
        self.movieTitleLabel.text = "Title: \(passedMovie.title ?? "")"
        self.movieReleaseYearLabel.text = "Release year: \(passedMovie.releaseYear)"
        self.rating.value = CGFloat(passedMovie.rating / 2)
        self.genresLabel.text = "Genres: "
        
        passedMovie.genres?.forEach({ (genre) in
            if let genreName = genre.name,
                let text = self.genresLabel.text {
                self.genresLabel.text = (text + genreName + " ")
            }
        })
    }
}
