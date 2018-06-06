//
//  GenreViewController.swift
//  Movie Night
//
//  Created by Nathan on 5/4/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

class GenreViewController: UICollectionViewController, Storyboarded {

  weak var coordinator: MainCoordinator?

  lazy var nextButton: UIBarButtonItem = {
    return UIBarButtonItem(barButtonSystemItem: .done, target: coordinator, action: #selector(MainCoordinator.selectActors))
  }()

  var genreList: [Genre] = [] {
    didSet {
      dataSource.update(with: genreList)
      print("Reloaded data with \(genreList)")
      DispatchQueue.main.async { [weak self] in
        self?.dataSource.collectionView.reloadData()
      }
    }
  }

  lazy var dataSource: GenreListDataSource = {
    return GenreListDataSource(genres: [], collectionView: self.collectionView!)
  }()

  let client = TMDBClient()

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.title = "Favorite Genres"
    collectionView?.dataSource = dataSource
    collectionView?.delegate = self
    collectionView?.allowsMultipleSelection = true

    if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
      if #available(iOS 11.0, *) {
        flowLayout.sectionInsetReference = .fromLayoutMargins
        flowLayout.minimumInteritemSpacing = 4
        flowLayout.minimumLineSpacing = 8
      }
    }

    client.send(GetGenres()) { [weak self] (result) in
      switch result {
      case .success(let genres):
        print("Updating genre list")
        self?.genreList = genres.genres
      case .failure:
        return
      }
    }

  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("Cell tapped at \(indexPath.row)")
    guard let selectedCell = collectionView.cellForItem(at: indexPath) else { return }
    UIView.animate(withDuration: 0.8) {
      selectedCell.layer.borderWidth = 3
      selectedCell.layer.borderColor = UIColor.blue.cgColor
    }
    if navigationItem.rightBarButtonItem == nil {
      navigationItem.rightBarButtonItem = nextButton
    }
  }

  override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    guard let selectedCell = collectionView.cellForItem(at: indexPath) else { return }
    UIView.animate(withDuration: 0.8) {
      selectedCell.layer.borderWidth = 0
      selectedCell.layer.borderColor = UIColor.clear.cgColor
    }

    if collectionView.indexPathsForSelectedItems == nil || collectionView.indexPathsForSelectedItems?.count == 0 {
      navigationItem.rightBarButtonItem = nil
    }
  }

  
}

extension GenreViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = 85
    let height = width + 20
    return CGSize(width: width, height: height)
  }

}
