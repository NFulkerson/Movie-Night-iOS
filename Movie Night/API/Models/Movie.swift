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

    let adult: Bool
    let backdropPath: String
//    let belongsToCollection: Bool?
    let budget: Int
    let genres: [Genre]
    let homepage: String?

    let originalLanguage: String
    let originalTitle: String

    let overview: String?
//    let popularity: Int
    let posterPath: String?
//    let productionCompanies: [Company]
//    let productionCountries: [Country]
    let releaseDate: String
    let revenue: Int
    let runtime: Int

//    let spokenLanguages: [Language]
    let status: ProductionStatus?
    let tagline: String
    let title: String
    let video: Bool
    let voteAverage: Int
    let voteCount: Int

}
