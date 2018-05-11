//
//  Status.swift
//  Movie Night
//
//  Created by Nathan on 4/8/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation

enum ProductionStatus: String, Decodable {
    case rumored
    case planned
    case inProduction
    case postProduction
    case released
    case canceled
}
