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
    return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finish))
  }()

  var selected: [Movie] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView?.dataSource = dataSource
    collectionView?.delegate = self
    collectionView?.prefetchDataSource = self
    let layout = PageCollectionLayout(itemSize: CGSize(width: 256, height: 460))
    collectionView?.setCollectionViewLayout(layout, animated: true)
    collectionView?.allowsMultipleSelection = true

    collectionView?.refreshControl = UIRefreshControl()
    collectionView?.refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
    getMovies()

  }

  @objc func refreshList() {
    currentPage = 1
    getMovies(refresh: true)
  }

  @objc func finish() {
    coordinator?.userDidFinishPickingMovies(selected)
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
    let item = dataSource.movies[indexPath.row]
    selected.append(item)

    if navigationItem.rightBarButtonItem == nil {
      navigationItem.rightBarButtonItem = submitButton
    }
  }

  override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    let item = dataSource.movies[indexPath.row]
    if let deselectedIndex = selected.index(of: item) {
      selected.remove(at: deselectedIndex)
    }

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
