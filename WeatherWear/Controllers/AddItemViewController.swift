//
//  AddItemViewController.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-01-06.
//

import UIKit

class AddItemViewController: UIViewController {

    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveItem))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Add Item"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = saveButton

    }
    
    @objc func saveItem(){
        
    }
    

}
