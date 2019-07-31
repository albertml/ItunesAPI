//
//  DetailViewController.swift
//  ItunesAPI
//
//  Created by Albert on 30/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblTrackName: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var imgArtwork: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblGenre: UILabel!

     var movie: Movies?
    
    func configureView() {
        
        if let nnMovie = movie {
            DispatchQueue.main.async {
                self.title = nnMovie.trackName
                self.imgArtwork.loadImage(imageUrl: nnMovie.artWorkBig)
                self.lblTrackName.text = nnMovie.trackName
                self.lblArtist.text = "Artist: " + nnMovie.trackArtist
                self.lblGenre.text = "Genre: " + nnMovie.genre
                self.lblPrice.text = "Price: $\(nnMovie.price)"
                self.detailDescriptionLabel.text = nnMovie.longDescription
            }
        } else {
            let realmManager = RealmManager()
            let allMovies = realmManager.getAllMovies()
            if !allMovies.isEmpty {
                let userDefaults = UserDefaults()
                if let lastPageOpen = userDefaults.getSavedData(key: "last-open-page") {
                    movie = allMovies[Int(lastPageOpen)!]
                    configureView()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

