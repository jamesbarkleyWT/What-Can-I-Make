//
//  HomeScreen.swift
//  WhatCanIMake_UITests
//
//  Created by James Barkley on 7/20/21.
//

import XCTest

class HomeScreen: XCTest {
    
    let app = XCUIApplication()
    
    
    var getStartedButton: XCUIElement {
        return app.buttons.matching(identifier: "Get Started   ").firstMatch
    }
    
    var appTitle: XCUIElement {
        return app.staticTexts["What Can I Make."].firstMatch
    }
    
    var homeScreenBackgroundImage: XCUIElement {
        return app.images.matching(identifier: "fruit-bowl").firstMatch
    }
    
    var appLogo: XCUIElement {
        return app.images.matching(identifier: "Logo").firstMatch
    }
    
    var appDetailsText: XCUIElement {
        return app.staticTexts["\"What Can I Make\" is a recipe app that helps users find amazing recipes utilizing ingredients they have on hand."].firstMatch
    }
    
    
    
    
}

