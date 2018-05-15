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


    func configure(with genre: String) {
//        imageView.image = UIImage(named: genre)
        genreLabel.text = genre
        imageView.image = UIImage(named: genre) ?? UIImage(named: "Default")
    }

}
