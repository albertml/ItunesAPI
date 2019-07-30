//
//  HomePresenter.swift
//  ItunesAPI
//
//  Created by Albert on 30/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import UIKit

class HomePresenter: HomeViewToPresenterProtocol {
    var router: HomePresenterToRouterProtocol?
    var view: HomeViewController!
    var interactor: HomePresenterToInteractorProtocol!
    var movies: [Movies] = []
    
    func setupNavigationButton() {
        view.setupNavigationButton()
    }
    
    func setupViews() {
        view.setupViews()
    }
    
    func goToItemDetail(movies movie: Movies, segue: UIStoryboardSegue) {
        router?.pushToItemDetailScreen(viewController: view, movie: movie, segue: segue)
    }
    
    func searchMovies(term: String) {
        interactor.searchMovies(term: term)
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    func successInGettingMovies(movies: [Movies]) {
        self.movies = movies
        view.successInGettingMovies()
        print(movies)
    }
    
    func failedInGettingMovies(errorMsg: String) {
        view.failedInGettingMovies(errorMsg: errorMsg)
    }
}
