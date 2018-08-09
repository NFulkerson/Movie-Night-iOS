//
//  StorageCoordinator.swift
//  Movie Night
//
//  Created by Nathan on 6/21/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation

class UserDataCoordinator: StorageCoordinator {
  var firstUser: MovieGoer = MovieGoer()
  var secondUser: MovieGoer = MovieGoer()

  var currentUser: User?

  var firstUserComplete: Bool = false
  var secondUserComplete: Bool = false

  func update(with movies: [Movie]) {
    guard let user = currentUser else {
      print("Couldn't update movies. User not determined.")
      return
    }
    switch user {
    case .first:
      firstUser.favoriteMovies = movies
    case .second:
      secondUser.favoriteMovies = movies
    }
  }

  func update(with actors: [Person]) {
    guard let user = currentUser else {
      print("Couldn't update actors. User not determined.")
      return
    }
    switch user {
    case .first:
      firstUser.favoriteActors = actors
    case .second:
      secondUser.favoriteActors = actors
    }
  }

  func update(with genres: [Genre]) {
    guard let user = currentUser else {
      print("Couldn't update genres. User not determined.")
      return
    }
    switch user {
    case .first:
      firstUser.favoriteGenres = genres
    case .second:
      secondUser.favoriteGenres = genres
    }
  }

}
