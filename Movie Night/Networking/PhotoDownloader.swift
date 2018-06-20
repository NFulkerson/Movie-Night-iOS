//
//  PhotoDownloader.swift
//  Movie Night
//
//  Created by Nathan on 6/11/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation

class PhotoDownloader {
  let session: URLSession

  init(configuration: URLSessionConfiguration) {
    self.session = URLSession(configuration: configuration)
  }

  convenience init() {
    self.init(configuration: .default)
  }

  typealias PhotoCompletion = (Data?, Error?) -> Void

  func retrieveImage(with request: URLRequest, completion: @escaping PhotoCompletion) -> URLSessionDataTask {
    if let cachedImage = URLCache.shared.cachedResponse(for: request)?.data {
      completion(cachedImage, nil)
    }
    let task = session.dataTask(with: request) { (data, response, error) in
      guard let data = data, let response = response as? HTTPURLResponse else {
        if let error = error {
          completion(nil, error)
        }
        return
      }
      if response.statusCode < 300 {
        let cachedData = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedData, for: request)
        completion(data, nil)
      }
    }
    return task
  }
}
