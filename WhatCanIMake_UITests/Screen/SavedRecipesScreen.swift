//
//  SavedRecipesScreen.swift
//  WhatCanIMake_UITests
//
//  Created by James Barkley on 7/26/21.
//

import XCTest

class SavedRecipesScreen: XCTest {

    let app = XCUIApplication()
    
    var savedRecipeTitle1: XCUIElement {
        return app.staticTexts["Saved"].firstMatch
    }
    
    var savedRecipeTitle2: XCUIElement {
        return app.staticTexts["Recipes."].firstMatch
    }
    
    var tipText: XCUIElement {
        return app.staticTexts["Swipe left to remove recipe."]
    }
    
    var savedIcon: XCUIElement {
        return app.images["saveColored"]
    }
    
    var listCount: Int {
        return app.tables.cells.count
    }
    
    var getFirstRecipe: XCUIElement {
        return app.tables.cells.element(boundBy: 0)
    }
    
    // Remove a saved recipe from list and returns if successful or not
    func removeSavedRecipe(ing: String, index: Int) -> Bool{
        app.tables.cells.element(boundBy: index).swipeLeft(velocity: 100.0)
        app.buttons["Delete"].firstMatch.tap()
        Thread.sleep(forTimeInterval: 3.0)
        return app.staticTexts[ing].exists
    }

}
