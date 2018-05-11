//
//  Person.swift
//  Movie Night
//
//  Created by Nathan on 4/8/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation

enum Gender: Int, Decodable {
    case unset = 0
    case female = 1
    case male = 2
}

struct Person: Decodable {
    let id: Int
    let imdbID: String

    let name: String
    let placeOfBirth: String?

    let profilePath: String
    let adult: Bool
    let alias: [String]
    let biography: String

    let birthday: String?
    let deathday: String?

    let gender: Gender
    let homepage: URL?

}
