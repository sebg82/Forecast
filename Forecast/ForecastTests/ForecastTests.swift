//
//  ForecastTests.swift
//  ForecastTests
//
//  Created by Sebastien Gohier on 28/12/2019.
//  Copyright © 2019 Sebastien Gohier. All rights reserved.
//

import XCTest
@testable import Forecast

class ForecastTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let viewModel = WeekVM()
        viewModel.reloadTable = {
            XCTAssertEqual(viewModel.numberOfRows, 9, "There is 9 weather forecast days")
            
            let dayVM = viewModel.dayVM(for: IndexPath(row: 0, section: 0))
            XCTAssertEqual(dayVM.getTemperature(), "4 ºC", "The temperature is 4 degrees")
        }
        viewModel.selected = { dayVM in
            XCTAssertEqual(dayVM.getHumidite(), "54 %", "The humidity is 54 percent")
        }
        viewModel.refreshScreen()
        viewModel.didSelectRowAt(IndexPath(row: 1, section: 0))

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
