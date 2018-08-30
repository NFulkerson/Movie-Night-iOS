//
//  UserFlowDelegate.swift
//  Movie Night
//
//  Created by Nathan on 7/4/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation

enum User {
  case first
  case second
}

protocol UserFlowDelegate: class {
  func userDidStartPickingFavorites(_ user: User)
  func userDidFinishPickingMovies(_ movies: [Movie])
  func userDidFinishPickingGenres(_ genres: [Genre])
  func userDidFinishPickingActors(_ actors: [Person])
}
