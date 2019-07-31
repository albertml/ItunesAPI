//
//  HomePresenter.swift
//  ItunesAPI
//
//  Created by Albert on 30/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import UIKit

class HomePresenter: HomeViewToPresenterProtocol {
    
    // Properties
    
    var router: HomePresenterToRouterProtocol?
    var view: HomeViewController!
    var interactor: HomePresenterToInteractorProtocol!
    var movies: [Movies] = []
    let realmManager = RealmManager()
    
    // Methods
    
    func setupNavigationButton() {
        view.setupNavigationButton()
    }
    
    func setupViews() {
        self.movies = getAllMovies()
        view.setupViews()
    }
    
    func goToItemDetail(movies movie: Movies, segue: UIStoryboardSegue) {
        router?.pushToItemDetailScreen(viewController: view, movie: movie, segue: segue)
    }
    
    func searchMovies(term: String) {
        interactor.searchMovies(term: term)
    }
    
    func getAllMovies() -> [Movies] {
        return realmManager.getAllMovies()
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    func successInGettingMovies() {
        self.movies = getAllMovies()
        view.successInGettingMovies()
    }
    
    func failedInGettingMovies(errorMsg: String) {
        view.failedInGettingMovies(errorMsg: errorMsg)
    }
}
