//
//  WeatherDayTableViewCell.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-03-04.
//

import UIKit

class WeatherDayTableViewCell: UITableViewCell {

    static let identifier = "WeatherDayTableViewCell"
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static func nib() -> UINib{
        return UINib(nibName: "WeatherDayTableViewCell", bundle: nil)
    }
    
    public func configure(temp: String, image: UIImage, date: String, description: String){
        temperatureLabel.text = temp
        weatherImage.image = image
        dateLabel.text = date
        descriptionLabel.text = description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.accessoryType = .disclosureIndicator
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
