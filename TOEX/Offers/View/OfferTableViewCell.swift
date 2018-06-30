//
//  OfferTableViewCell.swift
//  TOEX
//
//  Created by TaeGeun Moon on 2018. 6. 29..
//  Copyright © 2018년 TaeGeun Moon. All rights reserved.
//

import UIKit

class OfferTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var provideLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
