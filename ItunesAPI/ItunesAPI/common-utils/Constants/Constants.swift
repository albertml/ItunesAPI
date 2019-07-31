//
//  Constants.swift
//  ItunesAPI
//
//  Created by Albert on 31/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import Foundation

enum Constants {
    case lastopen, leavepage, showdetailsegue
}

extension Constants: CustomStringConvertible {
    var description: String {
        switch self {
        case .lastopen:
            return "last-open"
        case .leavepage:
            return "last-open-page"
        case .showdetailsegue:
            return "showDetail"
        }
    }
}
