//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Sergey Krasiuk on 12/12/2019.
//  Copyright © 2019 Sergey Krasiuk. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.posterImageView.layer.cornerRadius = 8.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    // MARK: - Configure
    
    func configure(with movie: Movie) {
        
        if let url = URL(string: movie.image ?? "") {
            self.posterImageView.kf.setImage(with: url)
        }
        
        self.movieTitle.text = movie.title
    }
}
