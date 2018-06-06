//
//  MovieCollectionCell.swift
//  Movie Night
//
//  Created by Nathan on 6/5/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {
  static let reuseIdentifier = "MovieCell"
  @IBOutlet weak var movieLabel: UILabel!

  var movie: Movie? {
    didSet {
      self.movieLabel.text = movie?.title
    }
  }

  func configure(with movie: Movie) {
    self.movie = movie
  }
}
