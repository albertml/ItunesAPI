//
//  MoviesTableViewCell.swift
//  ItunesAPI
//
//  Created by Albert on 30/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var lblTrackName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var imgArtWork: UIImageView!
    
    // MARK: Properties
    
    var movie: Movies! {
        didSet {
            lblTrackName.text = movie.trackName
            lblPrice.text = "\(movie.price)"
            lblGenre.text = movie.genre
            imgArtWork.loadImage(imageUrl: movie.artWorkSmall)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
