//
//  Genre.swift
//  Movie Night
//
//  Created by Nathan on 4/8/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation

struct Genre: Codable {
    var id: Int
    var name: String
}

struct GenreContainer: Decodable {
    let genres: [Genre]
}

struct GetGenres: APIRequest {
    typealias Response = GenreContainer
    var resourceName: String {
        return "genre/list"
    }
    var parameters: [URLQueryItem] = []
}
