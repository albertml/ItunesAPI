//
//  LoaderView.swift
//  ItunesAPI
//
//  Created by Albert on 31/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmManager {
    
    private func saveDataToRealm(object: Object) {
        do {
            let realm = try Realm()
            try! realm.write {
                realm.add(object)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func checkIfDataExist(object: Object.Type, id: Int) -> Bool {
        do {
            let realm = try Realm()
            return realm.object(ofType: object, forPrimaryKey: id) != nil
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return false
    }
    
    func saveMovieToDatabase(movie: Movies) {
        saveDataToRealm(object: movie)
    }
    
    func getAllMovies() -> [Movies] {
        do {
            let realm = try Realm()
            let movies = realm.objects(Movies.self)
            return Array(movies)
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
        
        return []
    }
    
    func deleteMovies() {
        do {
            let realm = try Realm()
            let movies = realm.objects(Movies.self)
            try! realm.write {
                realm.delete(movies)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
