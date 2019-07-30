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
    
    func setupNavigationButton() {
        view.setupNavigationButton()
    }
    
    func setupViews() {
        view.setupViews()
    }
    func goToItemDetail(date: NSDate, segue: UIStoryboardSegue) {
        router?.pushToItemDetailScreen(viewController: view, date: date, segue: segue)
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    func dummy() {
        //
    }
}
