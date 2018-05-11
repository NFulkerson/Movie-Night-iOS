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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func presentGenreVC(_ sender: Any) {
        coordinator?.selectGenres()
    }


    @IBAction func presentMovieVC(_ sender: Any) {
        coordinator?.selectMovies()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
