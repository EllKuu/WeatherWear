//
//  SeasonTableViewCell.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-03-23.
//

import UIKit

protocol SeasonTableViewCellDelegate: AnyObject {
    func didTapButton(sender: UIButton, summer: RadioButton, spring: RadioButton, fall: RadioButton, winter: RadioButton)
}

class SeasonTableViewCell: UITableViewCell {
    
    weak var delegate: SeasonTableViewCellDelegate?

    static let identifier = "SeasonTableViewCell"
    
    @IBOutlet var summerButton: RadioButton!
    @IBOutlet var springButton: RadioButton!
    @IBOutlet var fallButton: RadioButton!
    @IBOutlet var winterButton: RadioButton!
    
    @IBOutlet var seasonButtons: [RadioButton]!
    
    @IBAction func didTapSeasonButton(sender: UIButton){
       
        delegate?.didTapButton(sender: sender, summer: summerButton, spring: springButton, fall: fallButton, winter: winterButton)
    }
    
    
    static func nib() -> UINib{
        return UINib(nibName: "SeasonTableViewCell", bundle: nil)
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
