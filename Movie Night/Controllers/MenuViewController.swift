//
//  TestViewController.swift
//  Movie Night
//
//  Created by Nathan on 5/4/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, Storyboarded {

  weak var coordinator: MainCoordinator?

  @IBOutlet weak var userOneButton: UIButton!
  @IBOutlet weak var userTwoButton: UIButton!
  @IBOutlet weak var seeResultsButton: UIButton!

  lazy var attributionInfoButton: UIButton = {
    return UIButton(type: .infoLight)
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Movie Night"

    userOneButton.imageView?.contentMode = .scaleAspectFit
    userTwoButton.imageView?.contentMode = .scaleAspectFit
    userOneButton.imageEdgeInsets = UIEdgeInsetsMake(20, -40, 20, 0)
    userTwoButton.imageEdgeInsets = UIEdgeInsetsMake(20, -40, 20, 0)
    setupAttributionDisclosureButton()
  }

  override func viewWillAppear(_ animated: Bool) {
    guard let firstUserFinished = coordinator?.userCoordinator.firstUserComplete,
      let secondUserFinished = coordinator?.userCoordinator.secondUserComplete else {
        return
    }
    if firstUserFinished {
      userOneButton.imageView?.image = UIImage(named: "Check")
    }
    if secondUserFinished {
      userTwoButton.imageView?.image = UIImage(named: "Check")
    }
    if firstUserFinished && secondUserFinished {
      seeResultsButton.isHidden = false
    }
  }

  @IBAction func userOneTapped(_ sender: Any) {
    coordinator?.userDidStartPickingFavorites(.first)
  }
  
  @IBAction func userTwoTapped(_ sender: Any) {
    coordinator?.userDidStartPickingFavorites(.second)
  }

  @IBAction func seeResultsTapped(_ sender: Any) {
    coordinator?.findSuggestedFilms()
  }

  @objc func showAttributions() {
    print("Attributions!")
  }

  fileprivate func setupAttributionDisclosureButton() {
    attributionInfoButton.addTarget(self,
                                    action: #selector(showAttributions),
                                    for: .touchUpInside)
    let barButton = UIBarButtonItem(customView: attributionInfoButton)
    navigationItem.rightBarButtonItem = barButton
  }


}
