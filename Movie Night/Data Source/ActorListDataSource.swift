//
//  ActorListDataSource.swift
//  Movie Night
//
//  Created by Nathan on 5/14/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

class ActorListDataSource: NSObject, UICollectionViewDataSource {
    private var actors: [Person]
    let collectionView: UICollectionView

    init(actors: [Person], collectionView: UICollectionView) {
        self.actors = actors
        self.collectionView = collectionView
        super.init()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let actorCell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCollectionCell.reuseIdentifier, for: indexPath) as! ActorCollectionCell
        let actor = actors[indexPath.row]
        actorCell.configure(with: actor)
        return actorCell
    }

    func update(with actors: [Person]) {
        self.actors = actors
    }
    
}
