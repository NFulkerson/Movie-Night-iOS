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
  var totalMovies: Int = 0
  let collectionView: UICollectionView

  init(collectionView: UICollectionView) {
    self.collectionView = collectionView
    collectionView.register(LoadingCollectionViewCell.self, forCellWithReuseIdentifier: "loadingCell")
    super.init()
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return totalMovies
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if isLoadingIndex(indexPath) {
      let loadingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "loadingCell", for: indexPath) as! LoadingCollectionViewCell
      return loadingCell
    } else {
      let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.reuseIdentifier, for: indexPath) as! MovieCollectionCell
      let movie = movies[indexPath.row]
      movieCell.configure(with: movie)

      return movieCell
    }
  }

  private func isLoadingIndex(_ indexPath: IndexPath) -> Bool {
    return indexPath.row >= movies.count
  }

  
}
