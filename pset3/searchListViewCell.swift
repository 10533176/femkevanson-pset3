//
//  searchListViewCell.swift
//  pset3
//
//  Created by Femke van Son on 17-11-16.
//  Copyright © 2016 Femke van Son. All rights reserved.
//

import UIKit

class searchListViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
