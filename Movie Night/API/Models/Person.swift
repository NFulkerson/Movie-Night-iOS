//
//  Person.swift
//  Movie Night
//
//  Created by Nathan on 4/8/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

enum Gender: Int, Codable {
    case unset = 0
    case female = 1
    case male = 2
}

struct Person: Codable {

    var imageURLPath: URL? {
        guard let path = profilePath else {
            return nil
        }
        return URL(string: "https://image.tmdb.org/t/p/w185/\(path)")
    }

    let id: Int
    let name: String
    let profilePath: String?
    let biography: String?
    let gender: Gender?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath
        case biography
        case gender
    }

}
// fodder for generic
struct PersonContainer: Decodable {
    let page: Int
    let results: [Person]
    let totalResults: Int
    let totalPages: Int
}

struct GetPopularActors: APIRequest {
    typealias Response = PersonContainer

    var resourceName: String {
        return "person/popular"
    }
    var parameters: [URLQueryItem] = []
}

extension GetPopularActors {
    init(page: Int) {
        parameters.append(URLQueryItem(name: "page", value: "\(page)"))
    }
}
