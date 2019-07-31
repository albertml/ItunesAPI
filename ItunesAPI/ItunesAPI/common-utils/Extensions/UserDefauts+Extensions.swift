//
//  UIImageView+Extensions.swift
//  ItunesAPI
//
//  Created by Albert on 31/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import UIKit

extension UserDefaults {
    
    func saveData(key: String, value: String) {
        set(value, forKey: key)
    }
    
    func getSavedData(key: String) -> String? {
        return string(forKey: key)
    }
}
