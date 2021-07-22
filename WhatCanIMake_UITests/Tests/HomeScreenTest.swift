//
//  HomeScreenTest.swift
//  WhatCanIMake_UITests
//
//  Created by James Barkley on 7/20/21.
//

import XCTest

class HomeScreenTest: BaseTest {

    let homeScreen = HomeScreen()
    
    override func setUp(){
        super.setUp()
    }
    
    func testverifyElementsOnPage(){
        XCTAssertTrue(homeScreen.appDetailsText.exists)
        XCTAssertTrue(homeScreen.getStartedButton.exists)
        XCTAssertTrue(homeScreen.appTitle.exists)
        XCTAssertTrue(homeScreen.homeScreenBackgroundImage.exists)
        XCTAssertTrue(homeScreen.appLogo.exists)
    }
    
    func testGetStartedButton(){
        let searchScreen = SearchScreen()
        
        XCTAssertTrue(homeScreen.getStartedButton.exists)
        homeScreen.getStartedButton.tap()
        XCTAssertTrue(searchScreen.navBarBackButton.waitForExistence(timeout: 5.0))
    }
    
    
    override func tearDown() {
        super.tearDown()
    }

}
