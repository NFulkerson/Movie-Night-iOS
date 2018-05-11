//
//  Collection.swift
//  Movie Night
//
//  Created by Nathan on 4/8/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation

struct TMDBCollection: Decodable {
    let id: Int
    let name: String
    let overview: String

    let backdropPath: String
    let parts: [Movie]
}
