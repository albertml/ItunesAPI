//
//  Data+Extensions.swift
//  ItunesAPI
//
//  Created by Albert on 30/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Data {
    func getErrorMsg() -> String {
        do {
            let json = try JSON(data: self)
            let errors = json["error"].arrayValue
            if errors.count > 0 {
                let errorMsg = errors[0]["detail"].stringValue
                return errorMsg
            }
        } catch let parsingError {
            return parsingError.localizedDescription
        }
        
        return "Sorry for the incovenience. Please try again later"
    }
}
