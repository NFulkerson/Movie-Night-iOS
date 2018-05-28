//
//  LoadingCollectionViewCell.swift
//  Movie Night
//
//  Created by Nathan on 5/21/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//
//  Idea from: https://nsscreencast.com/episodes/315-tableview-prefetching

import UIKit

class LoadingCollectionViewCell: UICollectionViewCell {
    var activityIndicator: UIActivityIndicatorView!

    required init?(coder aDecoder: NSCoder) {
        fatalError("No decoder implemented for loading view cell.")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    private func setupCell() {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.activityIndicatorViewStyle = .gray
        indicator.hidesWhenStopped = true

        contentView.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            indicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            indicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])

        indicator.startAnimating()
    }
}
