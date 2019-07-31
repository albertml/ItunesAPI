//
//  HomeViewController.swift
//  ItunesAPI
//
//  Created by Albert on 30/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
//    var detailViewController: ItemDetailViewController? = nil
//    var objects = [Any]()
    
    // MARK: Properties
    
    var presenter: HomeViewToPresenterProtocol?
    let userDefaults = UserDefaults()
    var isFirstLoad = true
    
    
    // MARK: VC Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        navigationItem.leftBarButtonItem = editButtonItem
        
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
//        navigationItem.rightBarButtonItem = addButton
//        if let split = splitViewController {
//            let controllers = split.viewControllers
//            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ItemDetailViewController
//        }
        
        presenter?.setupNavigationButton()
        presenter?.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if presenter!.getAllMovies().isEmpty {
            showLoader()
            presenter?.searchMovies(term: "star")
        } else {
            if UIDevice.current.userInterfaceIdiom == .pad { return }
            if isFirstLoad {
                if let _ = userDefaults.getSavedData(key: "last-open-page") {
                    performSegue(withIdentifier: "showDetail", sender: nil)
                    isFirstLoad = false
                }
            }
        }
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                userDefaults.saveData(key: "last-open-page", value: "\(indexPath.row)")
                let movie = presenter!.movies[indexPath.row]
                presenter?.goToItemDetail(movies: movie, segue: segue)
            } else {
                if let lastPageOpen = userDefaults.getSavedData(key: "last-open-page") {
                    let movie = presenter!.movies[Int(lastPageOpen)!]
                    presenter?.goToItemDetail(movies: movie, segue: segue)
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let nnPresenter = presenter else { return 0 }
        return nnPresenter.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell: MoviesTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        movieCell.movie = presenter!.movies[indexPath.row]
        return movieCell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter!.movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lastViewedView: LastViewedTableViewCell = tableView.dequeueReusableNoIndexCell()
        lastViewedView.showLastViewed()
        return lastViewedView
    }
}

extension HomeViewController: HomePresenterToViewProtocol {
    func setupNavigationButton() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 22)]
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: 0xFF7E79)
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
    }
    
    func setupViews() {
        tableView.register(MoviesTableViewCell.self)
        tableView.register(LastViewedTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 80.0
    }
    
    func successInGettingMovies() {
        hideLoader()
        self.tableView.reloadData()
    }
    
    func failedInGettingMovies(errorMsg: String) {
        hideLoader()
        print(errorMsg)
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText.isEmpty {
            presenter?.searchMovies(term: "star")
            return
        }
        presenter?.searchMovies(term: searchText)
    }
}
