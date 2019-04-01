//
//  MatchesTableViewCell.swift
//  PREM
//
//  Created by Student on 3/28/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import UIKit

class MatchesTableViewCell: UITableViewCell {

    @IBOutlet weak var awayTeamImage: UIImageView!
    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var awayTeamScore: UILabel!
    @IBOutlet weak var homeTeamScore: UILabel!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
