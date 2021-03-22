//
//  AddDetailsTableViewCell.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-01-11.
//

import UIKit

class AddDetailsTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    static let identifier = "AddDetailsTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "AddDetailsTableViewCell", bundle: nil)
    }
    
    public func configure(with label: String, placeHolder: String){
        detailLabel.text = label
        detailTextField.placeholder = placeHolder
    }
    
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var detailTextField: UITextField!
    
    var textViewTextChangeCallback: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailTextField.delegate = self
        // Initialization code
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        detailTextField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textViewTextChangeCallback?(textField.text!)
    }
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


