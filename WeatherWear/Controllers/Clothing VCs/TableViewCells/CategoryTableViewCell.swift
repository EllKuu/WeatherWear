//
//  CategoryTableViewCell.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-03-15.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    //let checkbox = CircleCheckBox(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    
    static let identifier = "CategoryTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "CategoryTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let label = UILabel(frame: CGRect(x: 20, y: 5, width: 200, height: 70))
        label.text = "Tops"
        
        //contentView.addSubview(label)
        //contentView.addSubview(checkbox)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
