//
//  ActorCollectionController.swift
//  Movie Night
//
//  Created by Nathan on 5/14/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

class ActorCollectionController: UICollectionViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    var actors: [Person] = [] {
        didSet {
            dataSource.update(with: actors)
            DispatchQueue.main.async { [weak self] in
                self?.collectionView?.reloadData()
            }
        }
    }

    lazy var dataSource: ActorListDataSource = {
        return ActorListDataSource(actors: [], collectionView: self.collectionView!)
    }()

    let client = TMDBClient()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.dataSource = dataSource
        collectionView?.delegate = self

        client.send(GetPopularActors()) { [weak self] (result) in
            switch result {
            case .success(let actorList):
                self?.actors = actorList.results
            case .failure:
                return
            }
        }
    }

}

extension ActorCollectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 10) / 5
        let height = width + 25
        return CGSize(width: width, height: height)
    }
}
