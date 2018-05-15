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
    

    func configure(with actor: Person) {
        actorLabel.text = actor.name
        photo.image = UIImage(named: "Default")
    }
}
