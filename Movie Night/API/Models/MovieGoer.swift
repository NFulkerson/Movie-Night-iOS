//
//  MovieGoer.swift
//  Movie Night
//
//  Created by Nathan on 6/20/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation

struct MovieGoer: Codable {
  let favoriteGenres: [Genre]
  let favoriteActors: [Person]
  let favoriteMovies: [Movie]
}
