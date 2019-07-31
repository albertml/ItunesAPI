//
//  DetailViewController.swift
//  ItunesAPI
//
//  Created by Albert on 30/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblTrackName: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var imgArtwork: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblGenre: UILabel!

    var movie: Movies?
    
    // MARK: Methods
    
    func configureView() {
        
        // Check if movie is not nil, If so display data
        if let nnMovie = movie {
            self.title = nnMovie.trackName
            self.imgArtwork.loadImage(imageUrl: nnMovie.artWorkBig)
            self.lblTrackName.text = nnMovie.trackName
            self.lblArtist.text = "Artist: " + nnMovie.trackArtist
            self.lblGenre.text = "Genre: " + nnMovie.genre
            self.lblPrice.text = "Price: $\(nnMovie.price)"
            self.detailDescriptionLabel.text = nnMovie.longDescription
        } else {
            // Get data of last open page
            let realmManager = RealmManager()
            let allMovies = realmManager.getAllMovies()
            if !allMovies.isEmpty {
                let userDefaults = UserDefaults()
                if let lastPageOpen = userDefaults.getSavedData(key: Constants.leavepage.description) {
                    if Int(lastPageOpen)! > allMovies.count { return }
                    movie = allMovies[Int(lastPageOpen)!]
                    configureView()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        configureView()
    }
}

