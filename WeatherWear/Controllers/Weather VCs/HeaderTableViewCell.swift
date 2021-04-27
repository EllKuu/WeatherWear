//
//  HeaderTableViewCell.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-02-10.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    static let identifier = "HeaderTableViewCell"
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static func nib() -> UINib{
        return UINib(nibName: "HeaderTableViewCell", bundle: nil)
    }
    
    public func configure(location: String, temp: String, image: UIImage, date: String, description: String){
        locationLabel.text = location
        temperatureLabel.text = temp
        weatherImage.image = image
        dateLabel.text = date
        descriptionLabel.text = description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .systemBackground
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
