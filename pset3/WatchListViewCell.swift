//
//  WarchListViewCell.swift
//  pset3
//
//  Created by Femke van Son on 15-11-16.
//  Copyright © 2016 Femke van Son. All rights reserved.
//

import UIKit

class WatchListViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieDescription: UILabel!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var checkWatched: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
