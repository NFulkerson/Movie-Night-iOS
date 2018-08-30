//
//  GenreCollectionCell.swift
//  Movie Night
//
//  Created by Nathan on 5/14/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

class GenreCollectionCell: UICollectionViewCell {
  static let reuseIdentifier: String = "GenreCell"

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var genreLabel: UILabel!

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

  func configure(with genre: String) {
    //        imageView.image = UIImage(named: genre)
    genreLabel.text = genre
    imageView.image = UIImage(named: genre) ?? UIImage(named: "Default")
  }

}
