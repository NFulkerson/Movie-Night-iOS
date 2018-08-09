//
//  DecisionEngine.swift
//  Movie Night
//
//  Created by Nathan on 8/1/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation

class DecisionEngine {

  let client: TMDBClient
  weak var coordinator: MainCoordinator?

  init(with client: TMDBClient, coordinator: MainCoordinator) {
    self.client = client
    self.coordinator = coordinator
  }

  private func find(movies: [Movie], recommendationType: RecommendationType) {
    var similarMovies: [Movie] = []

    let movieDispatch = DispatchGroup()

    for movie in movies {
      movieDispatch.enter()
      let rec = RecommendedMovies(id: movie.id, list: recommendationType)
      client.send(rec) { (result) in
        switch result {
        case .success(let list):
          similarMovies.append(contentsOf: list.results)
        case .failure:
          debugPrint("Failed to get contents.")
        }
        movieDispatch.leave()
      }
    }

    movieDispatch.notify(queue: .main) {
      let uniquelySorted = Set<Movie>(similarMovies).sorted(by: { $0.title! < $1.title! })
      for movie in uniquelySorted {
        print(movie.title)
      }
    }
  }

  /// A helper method for determining the list of genres to filter on.
  ///
  /// - Parameters:
  ///   - user: A movie goer
  ///   - user2: A second movie goer
  ///   - strict: If true, the genre list will contain only genres liked by both users
  /// - Returns: A combined, unique list of genres
  private func determineGenres(for user: MovieGoer, and user2: MovieGoer, strict: Bool = true) -> [Genre] {
    if strict {
      return user.favoriteGenres.filter(user2.favoriteGenres.contains)
    }
    var genres = user.favoriteGenres
    genres.merge(user2.favoriteGenres)
    return genres
  }

  private func determineActors(for user: MovieGoer, and user2: MovieGoer, strict: Bool = true) -> [Person] {
    if strict {
      return user.favoriteActors.filter(user2.favoriteActors.contains)
    }
    var actors = user.favoriteActors
    actors.merge(user2.favoriteActors)
    return actors
  }

  func discoverFilms(with people: [Person], in genres: [Genre], completion: @escaping ([Movie]?) -> Void) {
    let personList = people.map({ "\($0.id)" }).joined(separator: "|")
    let genreList = genres.map({ "\($0.id)" }).joined(separator: "|")
    let discover = DiscoverMovies(parameters: [
      URLQueryItem(name: "with_genres", value: genreList),
      URLQueryItem(name: "with_people", value: personList)
      ])

    client.send(discover) { (result) in
      switch result {
      case .success(let films):
        completion(films.results)
      case .failure:
        completion(nil)
      }
    }
  }

  func findSuggestions(for user: MovieGoer, and user2: MovieGoer) {
//    var userFavorites = user.favoriteMovies
//    userFavorites.merge(user2.favoriteMovies)
//    findSuggestedFilms(from: userFavorites)

    let genres = determineGenres(for: user, and: user2, strict: true)
    let actors = determineActors(for: user, and: user2, strict: true)

    discoverFilms(with: actors, in: genres) { (movies) in
      guard let films = movies else {
        print("I got nothing.")
        return
      }
      for film in films {
        print(film.title)
      }
    }
  }

  func findSuggestedFilms(from favorites: [Movie]) {
    find(movies: favorites, recommendationType: .recommended)
  }

  
}
