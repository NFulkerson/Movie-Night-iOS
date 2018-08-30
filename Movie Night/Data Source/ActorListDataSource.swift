//
//  ActorListDataSource.swift
//  Movie Night
//
//  Created by Nathan on 5/14/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

class ActorListDataSource: NSObject, UICollectionViewDataSource {
  var actors: [Person] = []
  var totalActors: Int = 0
  let collectionView: UICollectionView

  init(collectionView: UICollectionView) {
    self.collectionView = collectionView
    collectionView.register(LoadingCollectionViewCell.self, forCellWithReuseIdentifier: "loadingCell")
    super.init()
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return totalActors
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    if isLoadingIndex(indexPath) {
      let loadingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "loadingCell", for: indexPath) as! LoadingCollectionViewCell
      return loadingCell
    } else {
      let actorCell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCollectionCell.reuseIdentifier, for: indexPath) as! ActorCollectionCell
      let actor = actors[indexPath.row]
      actorCell.photo.image = UIImage(named: "Default")
      actorCell.configure(with: actor)

      return actorCell
    }
  }

  func update(with actors: [Person]) {
    self.actors.append(contentsOf: actors)
  }

  private func isLoadingIndex(_ indexPath: IndexPath) -> Bool {
    return indexPath.row >= actors.count
  }

}
