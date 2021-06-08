//
//  ImageTableViewCell.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-01-11.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    static let identifier = "ImageTableViewCell"
    
    @IBOutlet var imageLabel: UILabel!
    @IBOutlet var imageCapture: UIImageView!
    
    static func nib() -> UINib{
        return UINib(nibName: "ImageTableViewCell", bundle: nil)
    }
    
    public func configure(with label: String, image: UIImage){
        imageLabel.text = label
        imageCapture.image = image
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
       
    }
    
    
    
    
}
