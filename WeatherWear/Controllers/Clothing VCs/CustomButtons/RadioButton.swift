//
//  RadioButton.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-03-17.
//

import UIKit

class RadioButton: UIButton {

   // Images
    let unCheckedCircle = UIImage(systemName: "circle")
    let checkedCircle = UIImage(systemName: "circle.fill")
    
    var isChecked: Bool = false{
        didSet{
            if isChecked {
                self.setImage(checkedCircle, for: UIControl.State.normal)
            }
            else {
                self.setImage(unCheckedCircle, for: UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
            self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
            self.isChecked = false
        }
            
        @objc func buttonClicked(sender: UIButton) {
            if sender == self {
                isChecked = !isChecked
            }
        }
    

}
