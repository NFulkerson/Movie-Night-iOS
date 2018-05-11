//
//  ViewController.swift
//  Movie Night
//
//  Created by Nathan on 4/6/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {

    override func viewDidLoad() {
        super.viewDidLoad()
        // stash this api key away later
        let apiKey = "ee27af53767941e284de0d1b5c3ace1c"
        let jsonDloader = JSONDownloader(configuration: .default)
        let url = URL(string: "https://api.themoviedb.org/3/movie/550?api_key=ee27af53767941e284de0d1b5c3ace1c")
        let request = URLRequest(url: url!)
        let task = jsonDloader.jsonDataTask(with: request) { data, error in
            guard let data = data else {
                print(error)
                return
            }
            let jsonDecoding = JSONDecoder()
            jsonDecoding.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let certList = try jsonDecoding.decode(Movie.self, from: data)
                print(certList)
            } catch {
                print(error)
            }

        }
        task.resume()

        let movieDeets = GetMovieDetails(id: "15")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

