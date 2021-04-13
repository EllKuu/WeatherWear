//
//  CategoryTableViewCell.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-03-15.
//

import UIKit

protocol CategoryTableViewCellDelegate: AnyObject {
    func didTapCategoryButton(sender: UIButton, categoryBtns: [RadioButton])
}

class CategoryTableViewCell: UITableViewCell {
    
    weak var delegate: CategoryTableViewCellDelegate?
    
    static let identifier = "CategoryTableViewCell"
    
    @IBOutlet var topButton: RadioButton!
    @IBOutlet var bottomButton: RadioButton!
    @IBOutlet var outerwearButton: RadioButton!
    @IBOutlet var shoesButton: RadioButton!
    @IBOutlet var otherButton: RadioButton!
    
    @IBOutlet var categoryButtons: [RadioButton]!
    
    @IBAction func didTapButton(sender: UIButton){
       
        delegate?.didTapCategoryButton(sender: sender, categoryBtns: categoryButtons)
    }
    
    
    static func nib() -> UINib{
        return UINib(nibName: "CategoryTableViewCell", bundle: nil)
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
