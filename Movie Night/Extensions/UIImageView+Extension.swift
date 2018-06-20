//
//  UIImageView+Extension.swift
//  Movie Night
//
//  Created by Nathan on 6/14/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

extension UIImageView {
  func loadImage(from url: URL, placeholder: UIImage?, urlCache: URLCache? = nil) {
    let cache = urlCache ?? URLCache.shared
    let urlRequest = URLRequest(url: url)
    if let data = cache.cachedResponse(for: urlRequest)?.data, let image = UIImage(data: data) {
      self.image = image
    } else {
      let downloader = PhotoDownloader()
      downloader.retrieveImage(with: urlRequest) { (data, error) in
        guard let imageData = data, let image = UIImage(data: imageData) else {
          return
        }
        DispatchQueue.main.async {
          self.image = image
        }
      }.resume()
    }
  }
}
