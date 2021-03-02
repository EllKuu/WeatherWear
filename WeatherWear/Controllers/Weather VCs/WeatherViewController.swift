//
//  WeatherViewController.swift
//  WeatherWear
//
//  Created by elliott kung on 2020-12-29.
//

import UIKit
import MapKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var weatherTable: UITableView!
    
    lazy var worldMapBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(self.openMap))
        return button
    }()
    
    var data_latitude: Double = 0.0
    var data_longitude: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "Weather"
        weatherTable.delegate = self
        weatherTable.dataSource = self
        
       
        
        // navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        setupBarButtons()
        
        // Header Section
        setupHeader()
    }
    
    func setupBarButtons(){
        navigationItem.rightBarButtonItem = worldMapBtn
    }
    
    func setupHeader(){
        let headerNib = (Bundle.main.loadNibNamed(HeaderTableViewCell.identifier, owner: self, options: nil)![0] as? HeaderTableViewCell)
        
        let image = UIImage(systemName: "house")
        headerNib?.configure(location: "Toronto", temp: "30", image: image!)
        
        weatherTable.tableHeaderView = headerNib
    }
    
    @objc func openMap(){
        let mapVC = storyboard?.instantiateViewController(identifier: "map") as! MapViewController
        
        mapVC.callBackCoordinates = { (latitude: Double, longitude: Double) in
            let weather = WeatherModel()
            weather.getWeatherData(latitude: latitude, longitude: longitude) {
                (weatherObj) in
                print("IN WEATHERVC")
                print(weatherObj)
              
            }
        }
        
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    

}


extension WeatherViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension WeatherViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "7 Day Outlook"
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        <#code#>
//    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "test"
        return cell
    }
    
    
}
