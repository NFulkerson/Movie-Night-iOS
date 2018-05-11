//
//  APIError.swift
//  Movie Night
//
//  Created by Nathan on 4/10/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case responseUnsuccessful
    case networkInterruption
    case invalidData(message: String)
    case decodingFailed(message: String)
    case resourceNotFound(message: String)
    case operationError(message: String)
}
