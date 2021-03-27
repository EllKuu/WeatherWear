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
    var weatherResult = WeatherModel()
    var weatherDayOfTheWeek = [WeatherModel.Daily]()
    var headerLocation = ""
    
    lazy var worldMapBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(self.openMap))
        return button
    }()
    
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
        setupHeader(location: "No", temp: "30", date: "No", image: UIImage(systemName: "house")!, description: "Test")
        
        weatherTable.register(UINib(nibName: WeatherDayTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: WeatherDayTableViewCell.identifier)
    }
    
    func setupBarButtons(){
        navigationItem.rightBarButtonItem = worldMapBtn
    }
    
    func setupHeader(location: String, temp: String, date: String, image: UIImage, description: String){
        let headerNib = (Bundle.main.loadNibNamed(HeaderTableViewCell.identifier, owner: self, options: nil)![0] as? HeaderTableViewCell)
        
        headerNib?.configure(location: location, temp: temp, image: image, date: date, description: description)
        
        weatherTable.tableHeaderView = headerNib
    }
    
    @objc func openMap(){
        let mapVC = storyboard?.instantiateViewController(identifier: "map") as! MapViewController
        
        mapVC.callBackCoordinates = { (latitude: Double, longitude: Double) in
            self.weatherResult.getWeatherData(latitude: latitude, longitude: longitude){
                (weatherObj) in
                self.weatherDataSetup(weatherData: weatherObj)
                self.weatherTable.reloadData()
            }
        }
        
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    func weatherDataSetup(weatherData: WeatherModel.WeatherData){
        
        if !weatherDayOfTheWeek.isEmpty{
            weatherDayOfTheWeek.removeAll()
        }
        
        // setup header data
        headerLocation = weatherData.timezone
        let headerTemp = String("\(Int(weatherData.current.temp.rounded())) C")
        let headerIcon = setIcon(iconID: weatherData.current.weather[0].icon)
        let headerDate = getDate(weatherInt: weatherData.current.dt)
        let headerDescription = weatherData.current.weather[0].description
        setupHeader(location: headerLocation, temp: headerTemp, date: headerDate, image: headerIcon, description: headerDescription)
        
        for i in weatherData.daily{
            weatherDayOfTheWeek.append(i)
        }
        
        print(weatherDayOfTheWeek.count)
        
        
    }
    
    func getDate(weatherInt: Int) -> String{
        let timeInterval = TimeInterval(weatherInt)
        let myNSDate = Date(timeIntervalSince1970: timeInterval)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        return dateFormatter.string(from: myNSDate)

    }
    
    func setIcon(iconID: String) -> UIImage{
         switch iconID {
         case "01d":
             return  UIImage(systemName: "sun.max.fill")!
         case "01n":
             return UIImage(systemName: "sun.max")!
         case "02d":
             return  UIImage(systemName: "cloud.sun.fill")!
         case "02n":
             return  UIImage(systemName: "cloud.sun")!
         case "03d":
             return  UIImage(systemName: "cloud.fill")!
         case "03n":
             return  UIImage(systemName: "cloud")!
         case "04d":
             return  UIImage(systemName: "cloud")!
         case "04n":
             return  UIImage(systemName: "cloud")!
         case "09d":
             return  UIImage(systemName: "cloud.rain.fill")!
         case "10d":
             return  UIImage(systemName: "cloud.sun.rain.fill")!
         case "11d":
             return  UIImage(systemName: "cloud.bolt.rain.fill")!
         case "13d":
             return  UIImage(systemName: "snow")!
         case "50d":
             return  UIImage(systemName: "cloud.fog.fill")!
         default:
             return  UIImage(systemName: "questionmark.circle")!
         }
     }

} // end of class


extension WeatherViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
} // end of extension

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
        if weatherDayOfTheWeek.isEmpty{
            return 0
        }
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDayTableViewCell.identifier, for: indexPath) as! WeatherDayTableViewCell
        if !weatherDayOfTheWeek.isEmpty{
            let num = Int(indexPath.item)
            let cellDate = getDate(weatherInt: weatherDayOfTheWeek[num].dt)
            let cellTemp = String("\(Int(weatherDayOfTheWeek[num].temp.day.rounded())) C")
            let cellIcon = setIcon(iconID: weatherDayOfTheWeek[num].weather[0].icon)
            let cellDescription = weatherDayOfTheWeek[num].weather[0].description
            
            cell.configure(temp: cellTemp, image: cellIcon, date: cellDate, description: cellDescription)
            
        }else{
            cell.configure(temp: "cellTemp", image: UIImage(systemName: "house")!, date: "cellDate", description: "cellDescription")
        }
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "clothingSuggestions") as! ClothingSuggestionsTableViewController
        vc.modalPresentationStyle = .fullScreen
        
        
        let cellDate = getDate(weatherInt: weatherDayOfTheWeek[indexPath.row].dt)
        let cellTemp = String("\(Int(weatherDayOfTheWeek[indexPath.row].temp.day.rounded())) C")
        let cellIcon = setIcon(iconID: weatherDayOfTheWeek[indexPath.row].weather[0].icon)
        let cellDescription = weatherDayOfTheWeek[indexPath.row].weather[0].description
        
        vc.setupHeader(location: headerLocation, temp: cellTemp, date: cellDate, image: cellIcon, description: cellDescription)
        vc.temperature = Int(weatherDayOfTheWeek[indexPath.row].temp.day.rounded())
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
} // End of extension
