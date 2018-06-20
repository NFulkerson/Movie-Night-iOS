//
//  MainCoordinator.swift
//  Movie Night
//
//  Created by Nathan on 5/4/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
  var childCoordinators = [Coordinator]()
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let vc = TestViewController.instantiate()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: false)
  }

  @objc func selectMovies() {
    let vc = MovieViewController.instantiate()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
  }

  @objc func selectGenres() {
    let vc = GenreViewController.instantiate()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
  }

  @objc func selectActors() {
    let vc = ActorCollectionController.instantiate()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
  }

  @objc func saveUser() {
//    start()
    navigationController.popToRootViewController(animated: true)
  }

}

