//
//  DukePersonViewCell.swift
//  ECE564_HW
//
//  Created by Andrew Krier on 3/10/21.
//  Copyright © 2021 ECE564. All rights reserved.
//

import UIKit

class DukePersonViewCell: UITableViewCell {
    
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
