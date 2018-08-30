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
  var presentingSuggestions: Bool = false

  private var isFetchingNextPage: Bool = false
  private var currentPage: Int = 1
  
  var dataSource: MovieListDataSource = MovieListDataSource()

  lazy var submitButton: UIBarButtonItem = {
    return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finish))
  }()

  var selected: [Movie] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView?.register(UINib(nibName: "MovieSelectionCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
    collectionView?.dataSource = dataSource
    collectionView?.delegate = self
    print("Hi, I am \(self). My datasource is \(dataSource)")
    let layout = PageCollectionLayout(itemSize: CGSize(width: 256, height: 460))
    collectionView?.setCollectionViewLayout(layout, animated: true)
    collectionView?.allowsMultipleSelection = true

  }

  @objc func finish() {
    coordinator?.userDidFinishPickingMovies(selected)
  }

  func getMovies() {

    client.send(GetPopularMovies()) { (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(let movies):
          self.update(with: movies.results)
        case .failure:
          return
        }
      }
    }
  }

  func update(with movies: [Movie]) {
    dataSource.update(with: movies)
    collectionView?.reloadData()
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

