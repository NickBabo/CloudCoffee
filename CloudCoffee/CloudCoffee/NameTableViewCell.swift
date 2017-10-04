//
//  NameTableViewCell.swift
//  CloudCoffee
//
//  Created by Osniel Lopes Teixeira on 04/10/2017.
//  Copyright © 2017 Nicholas Babo. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
