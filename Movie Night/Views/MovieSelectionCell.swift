//
//  MovieSelectionCell.swift
//  Movie Night
//
//  Created by Nathan on 8/9/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit
import ExpandingCollection

class MovieSelectionCell: UICollectionViewCell {
  static let reuseIdentifier = "MovieCell"
  
  @IBOutlet weak var posterView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var releaseYearLabel: UILabel!

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

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  func configure(with movie: Movie) {
    self.posterView.kf.setImage(with: movie.imageURLPath)
    self.titleLabel.text = movie.title
    self.genreLabel.text = movie.genres.map({$0.name}).joined(separator: "/")
    self.releaseYearLabel.text = movie.releaseYear
  }

}
