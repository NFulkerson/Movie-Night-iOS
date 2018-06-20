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

  @IBOutlet weak var moviePosterImageView: UIImageView!
  
  var movie: Movie? {
    didSet {
      self.movieLabel.text = movie?.title
    }
  }

  override var isSelected: Bool {
    didSet {
      if isSelected {
        UIView.animate(withDuration: 0.8) {
          self.layer.borderWidth = 3
          self.layer.borderColor = UIColor.blue.cgColor
        }
      } else {
        UIView.animate(withDuration: 0.8) {
          self.layer.borderWidth = 0
          self.layer.borderColor = UIColor.clear.cgColor
        }
      }
    }
  }

  func configure(with movie: Movie) {
    self.movie = movie
    self.moviePosterImageView.kf.setImage(with: movie.imageURLPath)
  }
}
