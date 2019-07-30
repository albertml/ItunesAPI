//
//  HomeRouter.swift
//  ItunesAPI
//
//  Created by Albert on 30/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import Foundation

class HomeRouter: HomePresenterToRouterProtocol {
    
    static func createHomeModule() -> HomeViewController {
        
        let homeVC = HomeViewController.instantiate(fromAppStoryboard: .Main)
        let presenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol = HomePresenter()
        let interactor: HomePresenterToInteractorProtocol = HomeInteractor()
        let router: HomePresenterToRouterProtocol = HomeRouter()
        
        homeVC.presenter = presenter
        presenter.view = homeVC
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return homeVC
    }
    
    func pushToItemDetailScreen(viewController: HomeViewController, date: NSDate) {
        let itemDetailModule = ItemDetailViewController.instantiate(fromAppStoryboard: .Main)
        itemDetailModule.detailItem = date
        viewController.navigationController?.pushViewController(itemDetailModule,animated: true)
    }
}
