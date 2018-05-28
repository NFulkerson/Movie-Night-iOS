//
//  ImageDownloader.swift
//  Movie Night
//
//  Created by Nathan on 5/23/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

class MovieImageDownloader: Operation {
    let imagePath: URL
    let movie: Movie

    init(with movie: Movie) {
        self.movie = movie
        let posterPath = movie.posterPath
        imagePath = URL(string:  "https://image.tmdb.org/t/p/w185/\(posterPath)")!
    }

    override func main() {
        if self.isCancelled {
            return
        }

        let imageData = try! Data(contentsOf: imagePath)

        if imageData.count > 0 {
            movie.image = UIImage(data: imageData)
            movie.imageState = .downloaded
        } else {
            movie.imageState = .failed
        }
    }
}
