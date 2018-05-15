//
//  Movie.swift
//  Movie Night
//
//  Created by Nathan on 4/8/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let imdbID: String?

    let backdropPath: String
    let belongsToCollection: Bool?
    let budget: Int
    let genres: [Genre]
    let homepage: String?

    let originalLanguage: String
    let originalTitle: String

    let overview: String?
    let popularity: Double
    let posterPath: String?
//    let productionCompanies: [Company]
//    let productionCountries: [Country]
    let releaseDate: String
    let revenue: Int
    let runtime: Int

//    let spokenLanguages: [Language]
    let tagline: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

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
