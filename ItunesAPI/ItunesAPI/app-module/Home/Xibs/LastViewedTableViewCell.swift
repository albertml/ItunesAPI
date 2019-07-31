//
//  LastViewedTableViewCell.swift
//  ItunesAPI
//
//  Created by Albert on 31/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import UIKit

class LastViewedTableViewCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var lblLastViewed: UILabel!
    
    func showLastViewed() {
        let userDefaults = UserDefaults()
        guard let lastOpen = userDefaults.getSavedData(key: Constants.lastopen.description) else {
            lblLastViewed.text = "Today"
            return
        }
        
        lblLastViewed.text = lastOpen
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
