//
//  VideoTableViewCell.swift
//  PREM
//
//  Created by Student on 4/4/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
