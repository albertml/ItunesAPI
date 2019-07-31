//
//  HomeViewController.swift
//  ItunesAPI
//
//  Created by Albert on 30/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    // MARK: Properties
    
    var presenter: HomeViewToPresenterProtocol?
    let userDefaults = UserDefaults()
    var isFirstLoad = true
    
    
    // MARK: VC Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup page rendering
        presenter?.setupNavigationButton()
        presenter?.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Check if saved movie, if empty then search for default 'star' term
        // Else display saved movie
        if presenter!.getAllMovies().isEmpty {
            showLoader()
            presenter?.searchMovies(term: "star")
        } else {
            if UIDevice.current.userInterfaceIdiom == .pad { return }
            if isFirstLoad {
                if let _ = userDefaults.getSavedData(key: Constants.leavepage.description) {
                    performSegue(withIdentifier: Constants.showdetailsegue.description, sender: nil)
                    isFirstLoad = false
                }
            }
        }
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showdetailsegue.description {
            if let indexPath = tableView.indexPathForSelectedRow {
                // Show detail of selected movie
                userDefaults.saveData(key: Constants.leavepage.description, value: "\(indexPath.row)")
                let movie = presenter!.movies[indexPath.row]
                presenter?.goToItemDetail(movies: movie, segue: segue)
            } else {
                // Handling selected item in last open page
                if let lastPageOpen = userDefaults.getSavedData(key: Constants.leavepage.description) {
                    if Int(lastPageOpen)! > presenter!.movies.count { return }
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
        self.performSegue(withIdentifier: Constants.showdetailsegue.description, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lastViewedView: LastViewedTableViewCell = tableView.dequeueReusableNoIndexCell()
        lastViewedView.showLastViewed()
        return lastViewedView
    }
}

extension HomeViewController: HomePresenterToViewProtocol {
    func setupNavigationButton() {
        // Setup navigation appearance
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: 0xFF7E79)
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        // Setup search controller
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.tintColor = .white
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = search
    }
    
    func setupViews() {
        // Setup tableview
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
        // Check if search text is not nil or empty
        guard let searchText = searchController.searchBar.text else { return }
        if searchText.isEmpty { return }
        presenter?.searchMovies(term: searchText)
    }
}
