//
//  Endpoint.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/1/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure
}

protocol Endpoint {
    var base: String { get }
    var path: String { get }

    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        return components
    }

    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }

    var url: URL {
        return urlComponents.url!
    }

}

