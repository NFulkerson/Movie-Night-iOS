//
//  Array+Extension.swift
//  Movie Night
//
//  Created by Nathan on 7/31/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
  public mutating func merge<C: Collection>(_ collection: C) where C.Iterator.Element == Element {
    let filteredList = collection.filter({!self.contains($0)})
    self.append(contentsOf: filteredList)
  }
}
