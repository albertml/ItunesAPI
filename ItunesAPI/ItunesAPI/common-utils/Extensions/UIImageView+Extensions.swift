//
//  UIImageView+Extensions.swift
//  ItunesAPI
//
//  Created by Albert on 30/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    func loadImage(imageUrl: String) {
        if let avatar = URL(string: imageUrl.urlImageEscaped) {
            let options = ImageLoadingOptions(
                placeholder: UIImage(named: "itunes"),
                transition: .fadeIn(duration: 0.33)
            )
            Nuke.loadImage(with: avatar, options: options, into: self)
        }
    }
}
