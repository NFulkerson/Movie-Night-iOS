//
//  Movie.swift
//  Movie Night
//
//  Created by Nathan on 4/8/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

class Movie: Codable {
  let id: Int

  let backdropPath: String
  let belongsToCollection: Bool?
//  let genres: [Genre]

  let overview: String?
  let popularity: Double
  let posterPath: String?

  let releaseDate: String
  let title: String

  let voteAverage: Double
  let voteCount: Int

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

struct ListContainer: Decodable {
  let page: Int
  let totalPages: Int
  let totalResults: Int
  let results: [Movie]
}
