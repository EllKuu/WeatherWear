//
//  DefaultHeaderTableViewCell.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-04-02.
//

import UIKit

class DefaultHeaderTableViewCell: UITableViewCell {
    
    static let identifier = "DefaultHeaderTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "DefaultHeaderTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .orange
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
