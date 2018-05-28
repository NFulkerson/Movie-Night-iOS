//
//  TMDB.swift
//  Movie Night
//
//  Created by Nathan on 4/11/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation

protocol APIRequest {
    associatedtype Response: Decodable
    var resourceName: String { get }
    var parameters: [URLQueryItem] { get }
}

protocol APIClient {
    typealias ResultCallback<Value> = (Result<Value>) -> Void
    func send<T: APIRequest>(
        _ request: T,
        completion: @escaping ResultCallback<T.Response>
    )
}

class TMDBClient: APIClient {
    let session: URLSession
    let apikey = "ee27af53767941e284de0d1b5c3ace1c"
    let apiBase = "https://api.themoviedb.org"

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func send<T: APIRequest>(_ request: T, completion: @escaping (Result<T.Response>) -> Void) {
        let endpoint = self.endpoint(for: request)
        let request = URLRequest(url: endpoint)
        print(request.url)
        let task = session.dataTask(with: request) { (data, response, error) in
            print("Session response: \(response?.description)")
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decoded = try decoder.decode(T.Response.self, from: data)

                    completion(.success(decoded))
                } catch {
                    print(error)
                    completion(.failure)
                }
            } else {
                print("No data")
                completion(.failure)
            }
        }

        task.resume()

    }

    private func endpoint<T: APIRequest>(for request: T) -> URL {
        guard var urlComponents = URLComponents(string: apiBase) else {
            return URL(string: "https://api.themoviedb.org")!
        }
        urlComponents.path = "/3/\(request.resourceName)"

        urlComponents.queryItems = request.parameters
        urlComponents.queryItems?.append(URLQueryItem(name: "api_key", value: apikey))
        
        print("Query Items: \(urlComponents.queryItems)")

        return urlComponents.url!

    }

}

