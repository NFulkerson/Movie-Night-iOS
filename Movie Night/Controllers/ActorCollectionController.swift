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
    var actors: [Person] = []
    let client = TMDBClient()

    private var isFetchingNextPage: Bool = false
    private var currentPage: Int = 1

    lazy var dataSource: ActorListDataSource = {
        return ActorListDataSource(collectionView: self.collectionView!)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Favorite Actors"
        collectionView?.dataSource = dataSource
        collectionView?.delegate = self
        collectionView?.prefetchDataSource = self

        collectionView?.refreshControl = UIRefreshControl()
        collectionView?.refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)

        getActors()
    }

    @objc func refreshList() {
        currentPage = 1
        getActors(refresh: true)
    }

    private func getActors(refresh: Bool = false) {
        isFetchingNextPage = true
        print("Fetching actors at page \(currentPage)")
        client.send(GetPopularActors(page: currentPage)) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let actorList):
                    print(actorList.results.first)
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

}

extension ActorCollectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 10) / 2
        let height = width + 25
        return CGSize(width: width, height: height)
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

    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("Would cancel prefetching")
    }

    private func fetchNextPage() {
        guard !isFetchingNextPage else {
            print("Already fetching... Returning.")
            return
        }
        currentPage += 1
        getActors()
    }
}
