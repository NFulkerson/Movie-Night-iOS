//
//  Coordinator.swift
//  Movie Night
//
//  Created by Nathan on 5/4/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

protocol Coordinator {
  var childCoordinators: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }

  func start()
}

protocol StorageCoordinator {
  var firstUser: MovieGoer { get set }
  var secondUser: MovieGoer { get set }
}
