//
//  Date+Extensions.swift
//  ItunesAPI
//
//  Created by Albert on 31/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateformatter.string(from: self)
    }
}
