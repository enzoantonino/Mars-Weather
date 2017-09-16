//
//  ExpandedArchiveTableViewCell.swift
//  MarsWeather
//
//  Created by Enzo Antonino on 16/09/2017.
//  Copyright © 2017 Enzo Antonino. All rights reserved.
//

import UIKit

class ExpandedArchiveTableViewCell: UITableViewCell {
    
    @IBOutlet var solLabel: UILabel!
    @IBOutlet var terrestrialDateLabel: UILabel!
    @IBOutlet var atmoOpacityLabel: UILabel!
    @IBOutlet var lsLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var absHumidityLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    @IBOutlet var seasonLabel: UILabel!
    @IBOutlet var sunriseLabel: UILabel!
    @IBOutlet var sunsetLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
