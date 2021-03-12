//
//  ClothingSuggestionsTableViewController.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-03-09.
//

import UIKit

class ClothingSuggestionsTableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var clothingSuggestions:[ClothingItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register
        tableView.register(ClothingCollectionTableViewCell.nib(), forCellReuseIdentifier: ClothingCollectionTableViewCell.identifier)
        
        fetchItems()

    }
    
    func fetchItems(){
        do {
            clothingSuggestions = try context.fetch(ClothingItem.fetchRequest())
        }catch{
            fatalError("Could not fetch items")
        }
    }
    
    func setupHeader(location: String, temp: String, date: String, image: UIImage, description: String){
        let headerNib = (Bundle.main.loadNibNamed(HeaderTableViewCell.identifier, owner: self, options: nil)![0] as? HeaderTableViewCell)
        
        headerNib?.configure(location: location, temp: temp, image: image, date: date, description: description)
        
        self.tableView.tableHeaderView = headerNib
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClothingCollectionTableViewCell.identifier, for: indexPath) as! ClothingCollectionTableViewCell
        cell.configure(with: clothingSuggestions)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Tops"
        case 1:
            return "Bottoms"
        case 2:
            return "Outerwear"
        case 3:
            return "Accessory"
        case 4:
            return "Shoes"
        default:
            return nil
        }
    }
    
    

   

}
