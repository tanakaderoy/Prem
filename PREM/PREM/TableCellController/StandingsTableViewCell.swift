//
//  StandingsTableViewCell.swift
//  PREM
//  
//  Created by Student on 4/10/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import UIKit

class StandingsTableViewCell: UITableViewCell {

    @IBOutlet weak var labelPostion: UILabel!
    @IBOutlet weak var clubImageView: UIImageView!
    @IBOutlet weak var labelPlayed: UILabel!
    @IBOutlet weak var labelWon: UILabel!
    @IBOutlet weak var labelDrawn: UILabel!
    @IBOutlet weak var labelLost: UILabel!
    @IBOutlet weak var labelGoalDifference: UILabel!
    @IBOutlet weak var labelPoints: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
