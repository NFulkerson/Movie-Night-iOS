//
//  ActorCollectionController.swift
//  Movie Night
//
//  Created by Nathan on 5/14/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.

import UIKit

class ActorCollectionController: UICollectionViewController, Storyboarded {

  weak var coordinator: MainCoordinator?
  let client = TMDBClient()

  private var isFetchingNextPage: Bool = false
  private var currentPage: Int = 1

  lazy var dataSource: ActorListDataSource = {
    return ActorListDataSource(collectionView: self.collectionView!)
  }()

  lazy var nextButton: UIBarButtonItem = {
    return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(nextStep))
  }()

  var selected: [Person] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView?.dataSource = dataSource
    collectionView?.delegate = self
    collectionView?.prefetchDataSource = self
    collectionView?.allowsMultipleSelection = true

    collectionView?.refreshControl = UIRefreshControl()
    collectionView?.refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
    getActors()
  }

  @objc func refreshList() {
    currentPage = 1
    getActors(refresh: true)
  }

  @objc func nextStep() {
    coordinator?.userDidFinishPickingActors(selected)
  }

  private func getActors(refresh: Bool = false) {
    isFetchingNextPage = true
    print("Fetching actors at page \(currentPage)")
    client.send(GetPopularActors(page: currentPage)) { (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(let actorList):
          self.dataSource.totalActors = actorList.totalResults
          self.dataSource.update(with: actorList.results)
          self.collectionView?.reloadData()
        case .failure:
          return
        }
        self.isFetchingNextPage = false
      }
    }
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = dataSource.actors[indexPath.row]
    selected.append(item)

    if navigationItem.rightBarButtonItem == nil {
      navigationItem.rightBarButtonItem = nextButton
    }
  }

  override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    let item = dataSource.actors[indexPath.row]
    if let index = selected.index(of: item) {
      selected.remove(at: index)
    }

    if collectionView.indexPathsForSelectedItems == nil || collectionView.indexPathsForSelectedItems?.count == 0 {
      navigationItem.rightBarButtonItem = nil
    }
  }
}

extension ActorCollectionController: UICollectionViewDataSourcePrefetching {

  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    let needsFetch = indexPaths.contains { $0.row >= self.dataSource.actors.count }
    if needsFetch {
      print("Fetching next page")
      fetchNextPage()
    }
  }

  private func fetchNextPage() {
    guard !isFetchingNextPage else {
      debugPrint("Already fetching... Returning.")
      return
    }
    currentPage += 1
    getActors()
  }
}
