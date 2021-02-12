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
    
    
    static func nib() -> UINib{
        return UINib(nibName: "HeaderTableViewCell", bundle: nil)
    }
    
    public func configure(location: String, temp: String, image: UIImage){
        locationLabel.text = location
        temperatureLabel.text = temp
        weatherImage.image = image
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
