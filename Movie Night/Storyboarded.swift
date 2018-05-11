//
//  Storyboarded.swift
//  Movie Night
//
//  Created by Nathan on 5/4/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        // returns full class name of "MovieNight.ViewControllerClass"
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        print(storyboard)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
