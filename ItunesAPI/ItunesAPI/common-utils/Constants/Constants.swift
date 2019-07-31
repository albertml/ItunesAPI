//
//  Constants.swift
//  ItunesAPI
//
//  Created by Albert on 31/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import Foundation

enum Constants {
    case lastopen, leavepage, showdetailsegue, clearicon, searchicon, placeholder, defaultsearch
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
        case .clearicon:
            return "ic_clear"
        case .searchicon:
            return "ic_search"
        case .placeholder:
            return "Search Movies"
        case .defaultsearch:
            return "star"
        }
    }
}
