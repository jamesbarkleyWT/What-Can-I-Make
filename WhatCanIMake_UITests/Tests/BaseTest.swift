//
//  BaseTest.swift
//  WhatCanIMake_UITests
//
//  Created by James Barkley on 7/20/21.
//

import XCTest

class BaseTest: XCTestCase {

    let app = XCUIApplication()
    
    // Ingredients used throughout the test
    let ingredientOne = "Chicken"
    let ingredientTwo = "Peas"
    let ingredientThree = "Bacon"
    
    override class func setUp() {
        super.setUp()
    }
    
    override func setUp() {
        continueAfterFailure = false
        super.setUp()
        app.launch()
    }
    
    override func tearDown() {
        takeScreenshot(testName: self.name)
        super.tearDown()
    }
    
    func takeScreenshot(testName: String) {
        let screenshot = XCUIScreen.main.screenshot()
        let fullScreenshotAttachment = XCTAttachment(screenshot: screenshot)
        fullScreenshotAttachment.name = testName
        fullScreenshotAttachment.lifetime = .deleteOnSuccess
        add(fullScreenshotAttachment)
    }

}

extension XCUIElement {
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        }
        else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
            coordinate.tap()
        }
    }
}
