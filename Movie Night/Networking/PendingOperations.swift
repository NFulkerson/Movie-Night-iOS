//
//  PendingOperations.swift
//  Movie Night
//
//  Created by Nathan on 5/23/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation

class PendingOperations {
    var downloadsInProgress = [IndexPath: Operation]()
    let downloadQueue = OperationQueue()
}
