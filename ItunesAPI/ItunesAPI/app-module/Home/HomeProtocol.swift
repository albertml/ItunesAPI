//
//  HomeProtocol.swift
//  ItunesAPI
//
//  Created by Albert on 30/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import UIKit

protocol HomePresenterToViewProtocol: class {
    func setupNavigationButton()
    func setupViews()
    func successInGettingMovies()
    func failedInGettingMovies(errorMsg: String)
}

protocol HomeViewToPresenterProtocol: class {
    var router: HomePresenterToRouterProtocol? { get set }
    var view: HomeViewController! { get set }
    var interactor: HomePresenterToInteractorProtocol! { get set }
    var movies: [Movies] { get set }
    func setupNavigationButton()
    func setupViews()
    func goToItemDetail(movies: Movies, segue: UIStoryboardSegue)
    func searchMovies(term: String)
}

protocol HomeInteractorToPresenterProtocol: class {
    func successInGettingMovies(movies: [Movies])
    func failedInGettingMovies(errorMsg: String)
}

protocol HomePresenterToRouterProtocol: class {
    static func createHomeModule() -> HomeViewController
    func pushToItemDetailScreen(viewController: HomeViewController, movie: Movies, segue: UIStoryboardSegue)
}

protocol HomePresenterToInteractorProtocol: class {
    var presenter: HomeInteractorToPresenterProtocol? { get set }
    func searchMovies(term: String)
    
}

