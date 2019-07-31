//
//  String+Extensions.swift
//  ItunesAPI
//
//  Created by Albert on 30/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import Foundation

extension String {
    var nserror: NSError {
        let genericError = NSError(
            domain: "Itunes",
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: self])
        return genericError
    }
    
    var urlImageEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
