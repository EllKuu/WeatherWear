//
//  WeatherModel.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-02-09.
//

import Foundation

class WeatherModel {
    
    struct WeatherData: Codable{
        let timezone: String
        let current: Current
        let daily: [Daily]
    }

    struct Current: Codable{
        var dt: Int
        var temp: Double
        var feels_like: Double
        var weather: [Weather]
    }

    struct Daily: Codable{
        var dt: Int
        var temp: Temperature
        var feels_like: Feels_Like
        var weather: [Weather]
        
    }
    
    struct Temperature: Codable{
        var day: Double
        var min: Double
        var max: Double
        var night: Double
        var eve: Double
        var morn: Double
    }
    
    struct Feels_Like: Codable {
        var day: Double
        var night: Double
        var eve: Double
        var morn: Double
    }
    
    struct Weather: Codable{
        let description: String
        let icon: String
    }
    
    
    var temperature = 0
    var summary = ""
    var icon = ""
    var timezone = ""
        
    func getWeatherData(latitude: Double, longitude: Double, completion: @escaping(WeatherData) -> Void){
        
        guard let url = URL(string: "\(MyConstants.WEATHER_URL)lat=\(latitude)&lon=\(longitude)&exclude=minutely,hourly,alerts&appid=\(MyConstants.API_KEY)") else {return }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async{
                    if let error = error{
                        print(error)
                        return
                    }
                    
                    guard let data = data else { return }
                   
                    
                    do{
                        let decoder = JSONDecoder()
                        let weatherObj = try decoder.decode(WeatherData.self, from: data)
                        print(weatherObj)
                        
                        completion(weatherObj)
                    }catch let jsonErr{
                        print(jsonErr)
                    }
                }
            }
            task.resume()
            
        }
}
