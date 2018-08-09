//
//  Movie.swift
//  Movie Night
//
//  Created by Nathan on 4/8/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

struct Movie: Codable {

  let id: Int

  let backdropPath: String?
  let belongsToCollection: Bool?
  let genres: [Genre] = []

  let overview: String?
  let popularity: Double?
  let posterPath: String?

  let releaseDate: String?
  let title: String?

  let voteAverage: Double?
  let voteCount: Int?

  var imageURLPath: URL? {
    guard let path = posterPath else {
      return nil
    }
    return URL(string: "https://image.tmdb.org/t/p/w185/\(path)")
  }

  private enum CodingKeys: String, CodingKey {
    case id
    case backdropPath
    case belongsToCollection
    case overview
    case popularity
    case posterPath
    case releaseDate
    case title
    case voteAverage
    case voteCount
  }

}

extension Movie: Hashable {
  var hashValue: Int {
    return self.id.hashValue
  }

  static func == (lhs: Movie, rhs: Movie) -> Bool {
    return lhs.id == rhs.id
  }
}

// MARK: Movie-related endpoints

struct GetMovieDetails: APIRequest {
  typealias Response = Movie

  var resourceName: String {
    return "movie/\(movieId)"
  }

  var parameters: [URLQueryItem] = []

  let movieId: Int

  init(id: Int) {
    movieId = id
  }
}

struct GetPopularMovies: APIRequest {
  typealias Response = ListContainer

  var resourceName: String {
    return "movie/popular"
  }

  var parameters: [URLQueryItem] = []
}

enum RecommendationType {
  case recommended
  case similar
}

struct RecommendedMovies: APIRequest {
  typealias Response = ListContainer

  let listType: RecommendationType

  var resourceName: String {
    switch listType {
    case .recommended:
      return "movie/\(movieId)/recommendations"
    case .similar:
      return "movie/\(movieId)/similar"
    }
  }

  var parameters: [URLQueryItem] = []
  let movieId: Int

  init(id: Int, list: RecommendationType) {
    movieId = id
    listType = list
  }
}

struct DiscoverMovies: APIRequest {
  typealias Response = ListContainer

  var resourceName: String {
    return "discover/movie"
  }

  var parameters: [URLQueryItem] = []

  mutating func with(people: [Person]) {
    let uniqueIds = Set<Int>(people.map({ $0.id }))
    let idList = Array<Int>(uniqueIds).map({ "\($0)" }).joined(separator: "|")
    let queryItem = URLQueryItem(name: "with_people", value: idList)
    parameters.append(queryItem)
  }

  mutating func with(genres: [Genre]) {
    let uniqueIds = Set<Int>(genres.map({ $0.id }))
    let idList = Array<Int>(uniqueIds).map({ "\($0)" }).joined(separator: "|")
    let queryItem = URLQueryItem(name: "with_genres", value: idList)
    parameters.append(queryItem)
  }
}

struct ListContainer: Decodable {
  let page: Int
  let totalPages: Int
  let totalResults: Int
  let results: [Movie]
}
