//
//  Certification.swift
//  Movie Night
//
//  Created by Nathan on 4/8/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation

struct Certification: Decodable {
    let certification: String
    let meaning: String
    let order: Int
}

struct CertificationsList: Decodable {
    let certifications: [String: [Certification]]
}
