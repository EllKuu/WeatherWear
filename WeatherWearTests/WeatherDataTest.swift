//
//  WeatherDataTest.swift
//  WeatherWearTests
//
//  Created by elliott kung on 2022-02-19.
//

import XCTest
@testable import WeatherWear

class WeatherDataTest: XCTestCase {
    
    func testCanParseWeather() throws {
        let json = """
        {
            
            "lat":33.44,
            "lon":-94.04,
            "timezone":"America/Chicago",
            "timezone_offset":-21600,
            "current":{
                "dt":1645284659,
                "sunrise":1645275367,
                "sunset":1645315451,
                "temp":280.37,
                "feels_like":279.58,
                "pressure":1031,
                "humidity":53,
                "dew_point":271.64,
                "uvi":3.08,
                "clouds":0,
                "visibility":10000,
                "wind_speed":1.54,
                "wind_deg":330,
                "weather":[
                    {
                        "id":800,
                        "main":"Clear",
                        "description":"clear sky",
                        "icon":"01d"
                    }
                ]
            },
            "daily":[
                {
                    "dt":1645293600,
                    "sunrise":1645275367,
                    "sunset":1645315451,
                    "moonrise":1645326900,
                    "moonset":1645282140,
                    "moon_phase":0.6,
                    "temp":{
                        "day":282.81,
                        "min":274.46,
                        "max":288.18,
                        "night":278.98,
                        "eve":283.5,
                        "morn":275.52
                    },
                    "feels_like":{
                        "day":282.81,
                        "night":276.7,
                        "eve":281.84,
                        "morn":273.49
                    },
                    "pressure":1031,
                    "humidity":45,
                    "dew_point":271.66,
                    "wind_speed":2.94,
                    "wind_deg":144,
                    "wind_gust":6.01,
                    "weather":[
                        {
                            "id":800,
                            "main":"Clear",
                            "description":"clear sky",
                            "icon":"01d"
                        }
                    ],
                    "clouds":0,
                    "pop":0,
                    "uvi":5.35
                },
                {
                    "dt":1645380000,
                    "sunrise":1645361702,
                    "sunset":1645401904,
                    "moonrise":1645417080,
                    "moonset":1645370280,
                    "moon_phase":0.64,
                    "temp":{
                        "day":288.51,
                        "min":276.63,
                        "max":290.78,
                        "night":284.66,
                        "eve":286.65,
                        "morn":276.96
                    },
                    "feels_like":{
                        "day":287.12,
                        "night":283.93,
                        "eve":285.65,
                        "morn":274.33
                    },
                    "pressure":1023,
                    "humidity":39,
                    "dew_point":274.69,
                    "wind_speed":5.49,
                    "wind_deg":199,
                    "wind_gust":12.51,
                    "weather":[
                        {
                            "id":804,
                            "main":"Clouds",
                            "description":"overcast clouds",
                            "icon":"04d"
                        }
                    ],
                    "clouds":97,
                    "pop":0,
                    "uvi":5.14
                },
                {
                    "dt":1645466400,
                    "sunrise":1645448036,
                    "sunset":1645488356,
                    "moonrise":1645507440,
                    "moonset":1645458540,
                    "moon_phase":0.67,
                    "temp":{
                        "day":290.24,
                        "min":285.71,
                        "max":293.15,
                        "night":292.27,
                        "eve":292.99,
                        "morn":286.63
                    },
                    "feels_like":{
                        "day":290.51,
                        "night":292.61,
                        "eve":293.41,
                        "morn":286.57
                    },
                    "pressure":1014,
                    "humidity":96,
                    "dew_point":289.63,
                    "wind_speed":6.74,
                    "wind_deg":196,
                    "wind_gust":14.92,
                    "weather":[
                        {
                            "id":500,
                            "main":"Rain",
                            "description":"light rain",
                            "icon":"10d"
                        }
                    ],
                    "clouds":100,
                    "pop":0.97,
                    "rain":2.02,
                    "uvi":1.18
                },
                {
                    "dt":1645552800,
                    "sunrise":1645534369,
                    "sunset":1645574809,
                    "moonrise":0,
                    "moonset":1645546920,
                    "moon_phase":0.71,
                    "temp":{
                        "day":294.96,
                        "min":282.69,
                        "max":294.96,
                        "night":282.69,
                        "eve":286.47,
                        "morn":292.15
                    },
                    "feels_like":{
                        "day":295.36,
                        "night":279.99,
                        "eve":286.1,
                        "morn":292.59
                    },
                    "pressure":1011,
                    "humidity":83,
                    "dew_point":292.02,
                    "wind_speed":6.88,
                    "wind_deg":217,
                    "wind_gust":15.66,
                    "weather":[
                        {
                            "id":501,
                            "main":"Rain",
                            "description":"moderate rain",
                            "icon":"10d"
                        }
                    ],
                    "clouds":100,
                    "pop":1,
                    "rain":24.18,
                    "uvi":3.36
                },
                {
                    "dt":1645639200,
                    "sunrise":1645620701,
                    "sunset":1645661261,
                    "moonrise":1645597920,
                    "moonset":1645635720,
                    "moon_phase":0.75,
                    "temp":{
                        "day":276.84,
                        "min":275.71,
                        "max":279.06,
                        "night":276.78,
                        "eve":275.71,
                        "morn":276.65
                    },
                    "feels_like":{
                        "day":272.87,
                        "night":273.43,
                        "eve":271.7,
                        "morn":272.54
                    },
                    "pressure":1029,
                    "humidity":59,
                    "dew_point":269.73,
                    "wind_speed":5.9,
                    "wind_deg":34,
                    "wind_gust":9.83,
                    "weather":[
                        {
                            "id":500,
                            "main":"Rain",
                            "description":"light rain",
                            "icon":"10d"
                        }
                    ],
                    "clouds":100,
                    "pop":0.97,
                    "rain":2.01,
                    "uvi":4
                },
                {
                    "dt":1645725600,
                    "sunrise":1645707032,
                    "sunset":1645747712,
                    "moonrise":1645688520,
                    "moonset":1645724880,
                    "moon_phase":0.78,
                    "temp":{
                        "day":277.45,
                        "min":275.98,
                        "max":277.72,
                        "night":277.72,
                        "eve":277.58,
                        "morn":275.98
                    },
                    "feels_like":{
                        "day":274.91,
                        "night":276.15,
                        "eve":275.72,
                        "morn":271.81
                    },
                    "pressure":1022,
                    "humidity":96,
                    "dew_point":276.89,
                    "wind_speed":4.93,
                    "wind_deg":62,
                    "wind_gust":9.85,
                    "weather":[
                        {
                            "id":500,
                            "main":"Rain",
                            "description":"light rain",
                            "icon":"10d"
                        }
                    ],
                    "clouds":100,
                    "pop":1,
                    "rain":12.07,
                    "uvi":4
                },
                {
                    "dt":1645812000,
                    "sunrise":1645793363,
                    "sunset":1645834163,
                    "moonrise":1645779000,
                    "moonset":1645814520,
                    "moon_phase":0.82,
                    "temp":{
                        "day":280.55,
                        "min":275.45,
                        "max":282.72,
                        "night":275.45,
                        "eve":278.69,
                        "morn":276.26
                    },
                    "feels_like":{
                        "day":277.82,
                        "night":272.04,
                        "eve":275.65,
                        "morn":271.87
                    },
                    "pressure":1029,
                    "humidity":60,
                    "dew_point":273.37,
                    "wind_speed":5.6,
                    "wind_deg":341,
                    "wind_gust":9.85,
                    "weather":[
                        {
                            "id":500,
                            "main":"Rain",
                            "description":"light rain",
                            "icon":"10d"
                        }
                    ],
                    "clouds":38,
                    "pop":1,
                    "rain":0.88,
                    "uvi":4
                },
                {
                    "dt":1645898400,
                    "sunrise":1645879692,
                    "sunset":1645920614,
                    "moonrise":1645869360,
                    "moonset":1645904760,
                    "moon_phase":0.85,
                    "temp":{
                        "day":280.97,
                        "min":271.87,
                        "max":284.21,
                        "night":278.95,
                        "eve":281.06,
                        "morn":271.87
                    },
                    "feels_like":{
                        "day":278.7,
                        "night":275.9,
                        "eve":279.54,
                        "morn":267.86
                    },
                    "pressure":1028,
                    "humidity":51,
                    "dew_point":271.5,
                    "wind_speed":4.26,
                    "wind_deg":66,
                    "wind_gust":8.98,
                    "weather":[
                        {
                            "id":802,
                            "main":"Clouds",
                            "description":"scattered clouds",
                            "icon":"03d"
                        }
                    ],
                    "clouds":49,
                    "pop":0,
                    "uvi":4
                }
            ]
        }
        """
        
        let jsonData = json.data(using: .utf8)!
        let result = try! JSONDecoder().decode(WeatherModel.WeatherData.self, from: jsonData)
        
        XCTAssertEqual(280.37, result.current.temp)
        XCTAssertEqual(279.58, result.current.feels_like)
        XCTAssertEqual("clear sky", result.current.weather[0].description)
        XCTAssertEqual("01d", result.current.weather[0].icon)
        
    }
    
    func testCanParseWeatherViaJSONFile(){
        
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "weather", ofType: "json") else {
            fatalError("json not found")
        }
        
        //print("\n\n\(pathString)\n\n")
        
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("unable to convert json to string")
        }
        
        let jsonData = json.data(using: .utf8)!
        let result = try! JSONDecoder().decode(WeatherModel.WeatherData.self, from: jsonData)
        
        XCTAssertEqual(280.37, result.current.temp)
        XCTAssertEqual(279.58, result.current.feels_like)
    }
    
    
    
    
}