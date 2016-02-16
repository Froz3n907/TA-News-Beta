//
//  InstagramTableViewCell.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 30/12/2015.
//  Copyright © 2015 FutureAppleCEO. All rights reserved.
//

import UIKit

class InstagramTableViewCell: UITableViewCell {
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var viewAccount: UIButton!
    @IBOutlet weak var accountImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
