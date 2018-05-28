//
//  ActorPhotoDownloader.swift
//  Movie Night
//
//  Created by Nathan on 5/28/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import Foundation
import UIKit.UIImage

class ActorPhotoDownloader: Operation {
    let imagePath: URL?
    let actor: Person
    
    init(with actor: Person) {
        print(actor)
        print(actor.profilePath)
        self.actor = actor

        self.imagePath = actor.imageURLPath
    }

    override func main() {
        if self.isCancelled {
            return
        }

        guard let imagePath = imagePath else {
            self.cancel()
            actor.imageState = .failed
            return
        }

        let imageData = try! Data(contentsOf: imagePath)

        if imageData.count > 0 {
            actor.photo = UIImage(data: imageData)
            actor.imageState = .downloaded
        } else {
            actor.imageState = .failed
        }
    }
}
