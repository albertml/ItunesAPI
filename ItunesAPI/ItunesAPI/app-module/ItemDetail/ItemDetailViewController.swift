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
        // Update the user interface for the detail item.
        if let nnMovie = movie {
            self.title = nnMovie.trackName
            imgArtwork.loadImage(imageUrl: nnMovie.artWorkBig)
            lblTrackName.text = nnMovie.trackName
            lblArtist.text = "Artist: " + nnMovie.trackArtist
            lblGenre.text = "Genre: " + nnMovie.genre
            lblPrice.text = "Price: $\(nnMovie.price)"
            detailDescriptionLabel.text = nnMovie.description
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

