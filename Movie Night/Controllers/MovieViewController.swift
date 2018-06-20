//
//  MovieViewController.swift
//  Movie Night
//
//  Created by Nathan on 5/4/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

class MovieViewController: UICollectionViewController, Storyboarded {

  weak var coordinator: MainCoordinator?
  let client = TMDBClient()

  private var isFetchingNextPage: Bool = false
  private var currentPage: Int = 1

  lazy var dataSource: MovieListDataSource = {
    return MovieListDataSource(collectionView: self.collectionView!)
  }()

  lazy var submitButton: UIBarButtonItem = {
    return UIBarButtonItem(barButtonSystemItem: .done, target: coordinator, action: #selector(MainCoordinator.saveUser))
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView?.dataSource = dataSource
    collectionView?.delegate = self
    collectionView?.prefetchDataSource = self
    collectionView?.allowsMultipleSelection = true

    collectionView?.refreshControl = UIRefreshControl()
    collectionView?.refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
    getMovies()
  }

  @objc func refreshList() {
    currentPage = 1
    getMovies(refresh: true)
  }

  func getMovies(refresh: Bool = false) {

    client.send(GetPopularMovies()) { (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(let movies):
         self.dataSource.update(with: movies.results)
          self.collectionView?.reloadData()
        case .failure:
          return
        }
      }
    }
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("Cell tapped at \(indexPath.row)")

    if navigationItem.rightBarButtonItem == nil {
      navigationItem.rightBarButtonItem = submitButton
    }
  }

  override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

    if collectionView.indexPathsForSelectedItems == nil || collectionView.indexPathsForSelectedItems?.count == 0 {
      navigationItem.rightBarButtonItem = nil
    }
  }
}

extension MovieViewController: UICollectionViewDataSourcePrefetching {
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    print("Should prefetch")
  }
}
