//
//  HomeProtocol.swift
//  ItunesAPI
//
//  Created by Albert on 30/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import Foundation

protocol HomePresenterToViewProtocol: class {
    func setupNavigationButton()
    func setupViews()
}

protocol HomeViewToPresenterProtocol: class {
    var router: HomePresenterToRouterProtocol? { get set }
    var view: HomeViewController! { get set }
    var interactor: HomePresenterToInteractorProtocol! { get set }
    func setupNavigationButton()
    func setupViews()
    func goToItemDetail(date: NSDate)
}

protocol HomeInteractorToPresenterProtocol: class {
    func dummy()
}

protocol HomePresenterToRouterProtocol: class {
    static func createHomeModule() -> HomeViewController
    func pushToItemDetailScreen(viewController: HomeViewController, date: NSDate)
}

protocol HomePresenterToInteractorProtocol: class {
    var presenter: HomeInteractorToPresenterProtocol? { get set }
    func dummy()
    
}

