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

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func send<T: APIRequest>(_ request: T, completion: @escaping (Result<T.Response>) -> Void) {
        let endpoint = self.endpoint(for: request)
        let request = URLRequest(url: endpoint)
        print("Henlo world")
        let task = session.dataTask(with: request) { (data, response, error) in
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
        return URL(string: "https://api.themoviedb.org/3/\(request.resourceName)?api_key=\(apikey)")!
    }

}

