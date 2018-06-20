//
//  ActorCollectionCell.swift
//  Movie Night
//
//  Created by Nathan on 5/14/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

class ActorCollectionCell: UICollectionViewCell {
  static let reuseIdentifier: String = "ActorCell"
  
  @IBOutlet weak var actorLabel: UILabel!
  @IBOutlet weak var photo: UIImageView!

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
    self.photo.loadImage(from: url, placeholder: UIImage(named: "Default"))
  }

}
