//
//  MovieListDataSource.swift
//  Movie Night
//
//  Created by Nathan on 6/5/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

class MovieListDataSource: NSObject, UICollectionViewDataSource {
  var movies: [Movie] = []
//  var totalMovies: Int = 0

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSelectionCell.reuseIdentifier, for: indexPath) as! MovieSelectionCell
    let movie = movies[indexPath.row]
    movieCell.posterView.image = UIImage(named: "Default")
    movieCell.configure(with: movie)

    return movieCell
  }

  func update(with films: [Movie]) {
    self.movies = films
    print("Updated films")
  }

  private func isLoadingIndex(_ indexPath: IndexPath) -> Bool {
    return indexPath.row >= movies.count
  }

}
