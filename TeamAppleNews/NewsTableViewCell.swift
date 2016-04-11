//
//  NewsTableViewCell.swift
//  TA News
//
//  Created by Toby Woollaston on 11/04/2016.
//  Copyright © 2016 FutureAppleCEO. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDetail: UILabel!
    @IBOutlet weak var articleImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
