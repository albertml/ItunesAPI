//
//  HomeEntity.swift
//  ItunesAPI
//
//  Created by Albert on 30/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import Foundation
import RealmSwift

//struct Movies {
//    let trackArtist: String
//    let trackName: String
//    let artWorkSmall: String
//    let artWorkBig: String
//    let price: Double
//    let genre: String
//    let longDescription: String
//}

class Movies: Object {
    @objc dynamic var id = 0
    @objc dynamic var trackArtist = ""
    @objc dynamic var trackName = ""
    @objc dynamic var artWorkSmall = ""
    @objc dynamic var artWorkBig = ""
    @objc dynamic var price = 0.0
    @objc dynamic var genre = ""
    @objc dynamic var longDescription = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
