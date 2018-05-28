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

}

extension GenreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width-20)/3
        let height = width + 25
        return CGSize(width: width, height: height)
    }
}
