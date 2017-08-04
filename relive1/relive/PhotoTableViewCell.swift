//
//  PhotoTableViewCell.swift
//  relive
//
//  Created by Elizabeth McRae on 7/27/17.
//  Copyright © 2017 Elizabeth McRae. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var sigNameLabel: UILabel!
    @IBOutlet weak var mainNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
