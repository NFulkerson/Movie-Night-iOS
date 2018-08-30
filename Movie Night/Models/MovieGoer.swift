//
//  MovieGoer.swift
//  Movie Night
//
//  Created by Nathan on 6/20/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation

struct MovieGoer: Codable {
  var favoriteGenres: [Genre] = []
  var favoriteActors: [Person] = []
  var favoriteMovies: [Movie] = []
}

extension MovieGoer {
  init(with favorite: [Movie]) {
    favoriteMovies = favorite
  }

  init(with favorite: [Genre]) {
    favoriteGenres = favorite
  }

  init(with favorite: [Person]) {
    favoriteActors = favorite
  }
}
