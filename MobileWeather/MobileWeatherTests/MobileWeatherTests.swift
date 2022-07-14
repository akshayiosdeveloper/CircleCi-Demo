//
//  MobileWeatherTests.swift
//  MobileWeatherTests
//
//  Created by Akshay Kumar on 06/07/22.
//

import XCTest
@testable import MobileWeather

class MobileWeatherTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNumericExample() {
        let i = 1
        XCTAssert(i == 1 , "I supposed to 1")
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
