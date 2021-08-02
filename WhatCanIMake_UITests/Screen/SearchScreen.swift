//
//  SearchScreen.swift
//  WhatCanIMake_UITests
//
//  Created by James Barkley on 7/21/21.
//

import XCTest

class SearchScreen: XCTest {

    let app = XCUIApplication()
    
    var navBarBackButton: XCUIElement {
        return app.navigationBars.buttons["Back"].firstMatch
    }
    
    var navBarTitle: XCUIElement {
        return app.navigationBars.staticTexts["Add Ingredients"].firstMatch
    }
    
    var navBarAddButton: XCUIElement {
        return app.navigationBars.buttons["Add"].firstMatch
    }
    
    var welcomeTitle: XCUIElement {
        return app.staticTexts["Welcome."].firstMatch
    }

    
    var welcomeDetails: XCUIElement {
        return app.staticTexts["Create a list of ingredients below by using the \"+\" icon at the top to use in your search."].firstMatch
    }
    
    var searchButton: XCUIElement {
        return app.buttons.matching(identifier: "Search").firstMatch
    }
    
    var viewSavedRecipesButton: XCUIElement {
        return app.buttons.matching(identifier: "View Saved Recipes").firstMatch
    }
    
    var swiftInfoText: XCUIElement {
        return app.staticTexts["Swipe Left to Remove Ingredient"].firstMatch
    }
    
    func checkIngredientInListView(ing: String) -> Bool {
        return app.staticTexts[ing].firstMatch.exists
    }

}
