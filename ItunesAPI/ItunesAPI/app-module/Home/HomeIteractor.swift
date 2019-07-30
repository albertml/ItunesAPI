//
//  HomeIteractor.swift
//  ItunesAPI
//
//  Created by Albert on 30/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import Foundation
import SwiftyJSON

class HomeInteractor: HomePresenterToInteractorProtocol {
    var presenter: HomeInteractorToPresenterProtocol?
    
    func searchMovies(term: String) {
        ItunesProvider.request(Itunes.searctItem(term)) { result in
            switch result {
            case let .success(response):
                do {
                    let json = try JSON(data: response.data)
                    
                    if json["errors"].arrayValue.isEmpty {
                        if response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204 {
                            let json = try JSON(data: response.data)
                            let results = json["results"].arrayValue
                            let movies = self.parseMovies(json: results)
                            self.presenter?.successInGettingMovies(movies: movies)
                        } else {
                            self.presenter?.failedInGettingMovies(errorMsg: response.data.getErrorMsg())
                        }
                    } else {
                        self.presenter?.failedInGettingMovies(errorMsg: response.data.getErrorMsg())
                    }
                } catch (let error) {
                    self.presenter?.failedInGettingMovies(errorMsg: error.localizedDescription)
                }
            case let .failure(errorMsg):
                self.presenter?.failedInGettingMovies(errorMsg: errorMsg.localizedDescription)
            }
        }
    }
    
    private func parseMovies(json: [JSON]) -> [Movies] {
        var movieList: [Movies] = []
        for movie in json {
            let trackArtist = movie["artistName"].stringValue
            let trackName = movie["trackName"].stringValue
            let artWorkSmall = movie["artworkUrl60"].stringValue
            let artWorkBig = movie["artworkUrl100"].stringValue
            let price = movie["trackPrice"].doubleValue
            let genre = movie["primaryGenreName"].stringValue
            let description = movie["longDescription"].stringValue
            
            let movies = Movies(trackArtist: trackArtist, trackName: trackName, artWorkSmall: artWorkSmall, artWorkBig: artWorkBig, price: price, genre: genre, description: description)
            movieList.append(movies)
        }
        
        return movieList
    }
}
