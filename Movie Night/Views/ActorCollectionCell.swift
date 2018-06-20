//
//  ActorCollectionCell.swift
//  Movie Night
//
//  Created by Nathan on 5/14/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit
import Kingfisher

class ActorCollectionCell: UICollectionViewCell {
  static let reuseIdentifier: String = "ActorCell"
  
  @IBOutlet weak var actorLabel: UILabel!
  @IBOutlet weak var photo: UIImageView!

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

  var actor: Person? {
    didSet {
      actorLabel.text = actor?.name
    }
  }

  func configure(with actor: Person) {
    self.actor = actor
    guard let url = actor.imageURLPath else {
      return
    }
    self.photo.kf.setImage(with: url)
  }

}
