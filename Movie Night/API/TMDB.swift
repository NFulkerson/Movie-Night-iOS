//
//  TMDB.swift
//  Movie Night
//
//  Created by Nathan on 4/11/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation

protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    var resourceName: String { get }
}

protocol TMDBClient {
    typealias ResultCallback<Value> = (Result<Value>) -> Void
    func send<T: APIRequest>(
        _ request: T,
        completion: @escaping ResultCallback<T.Response>
    )
}

class TMDBAPI: TMDBClient {

    func send<T>(_ request: T, completion: @escaping (Result<T.Response>) -> Void) where T : APIRequest {
        
    }
}

struct GetMovieDetails: APIRequest {
    typealias Response = [Movie]
    var resourceName: String {
        return "/movie/\(id)"
    }
    
    let id: String
}
