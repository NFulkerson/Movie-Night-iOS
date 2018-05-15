//
//  GenreListDataSource.swift
//  Movie Night
//
//  Created by Nathan on 5/14/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

class GenreListDataSource: NSObject, UICollectionViewDataSource {
    private var genres: [Genre]
    let collectionView: UICollectionView

    init(genres: [Genre], collectionView: UICollectionView) {
        self.genres = genres
        self.collectionView = collectionView
        super.init()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let genreCell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionCell.reuseIdentifier, for: indexPath) as! GenreCollectionCell
        let genre = genres[indexPath.row]
        genreCell.configure(with: genre.name)

        return genreCell
    }

    func update(with genres: [Genre]) {
        self.genres = genres
    }

}
