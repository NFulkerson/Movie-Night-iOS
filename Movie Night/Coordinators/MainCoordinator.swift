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

  lazy var userCoordinator = UserDataCoordinator()
  let client = TMDBClient()

  weak var delegate: UserFlowDelegate?

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let vc = MenuViewController.instantiate()
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

  @objc func findSuggestedFilms() {
    let decisionMaker = DecisionEngine(with: client, coordinator: self)
    let combined = userCoordinator.firstUser.favoriteMovies + userCoordinator.secondUser.favoriteMovies
    decisionMaker.findSuggestions(for: userCoordinator.firstUser, and: userCoordinator.secondUser)
  }

  func presentSuggestions() {
    let vc = MovieViewController.instantiate()
    vc.coordinator = self
    
  }

  func finish() {
    navigationController.popToRootViewController(animated: true)
  }

}

extension MainCoordinator: UserFlowDelegate {
  func userDidStartPickingFavorites(_ user: User) {
    userCoordinator.currentUser = user
    selectGenres()
  }

  func userDidFinishPickingMovies(_ movies: [Movie]) {
    userCoordinator.update(with: movies)

    guard let user = userCoordinator.currentUser else {
      finish()
      return
    }
    switch user {
    case .first:
      userCoordinator.firstUserComplete = true
    case .second:
      userCoordinator.secondUserComplete = true
    }
    finish()
    
  }

  func userDidFinishPickingGenres(_ genres: [Genre]) {
    userCoordinator.update(with: genres)
    selectActors()
  }

  func userDidFinishPickingActors(_ actors: [Person]) {
    userCoordinator.update(with: actors)
    selectMovies()
  }

}

