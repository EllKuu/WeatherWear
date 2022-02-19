//
//  WeatherWearUITests.swift
//  WeatherWearUITests
//
//  Created by elliott kung on 2022-02-19.
//

import XCTest

class WeatherWearUITests: XCTestCase {

    override func setUpWithError() throws {
    
        continueAfterFailure = false

       
    }


    func testMapButtonOpensMapVC() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.navigationBars["Weather"].buttons["show map"].tap()
        app.navigationBars["WeatherWear.MapView"].buttons["Weather"].tap()

    }

    
}
