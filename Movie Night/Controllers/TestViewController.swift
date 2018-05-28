//
//  TestViewController.swift
//  Movie Night
//
//  Created by Nathan on 5/4/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Night"
    }

    @IBAction func presentGenreVC(_ sender: Any) {
        coordinator?.selectGenres()
    }


    @IBAction func presentMovieVC(_ sender: Any) {
        coordinator?.selectActors()
    }

}
