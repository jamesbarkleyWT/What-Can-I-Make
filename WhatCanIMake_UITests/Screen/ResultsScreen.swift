//
//  ResultsScreen.swift
//  WhatCanIMake_UITests
//
//  Created by James Barkley on 7/21/21.
//

import XCTest

class ResultsScreen: XCTest {

    let app = XCUIApplication()
    
    var resultsTitle: XCUIElement {
        return app.staticTexts["Results."].firstMatch
    }
    
    var tipText: XCUIElement {
        return app.staticTexts["Swipe down to return to change ingredients."]
    }
    
    var listCount: Int {
        return app.tables.cells.count
    }
    
    var getFirstRecipe: XCUIElement {
        return app.tables.cells.element(boundBy: 0)
    }

}
