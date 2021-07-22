//
//  AddIngredientsScreen.swift
//  WhatCanIMake_UITests
//
//  Created by James Barkley on 7/21/21.
//

import XCTest

class AddIngredientsScreen: XCTest {

    let app = XCUIApplication()
    
    var navBarCancelButton: XCUIElement {
        return app.navigationBars.buttons["Cancel"].firstMatch
    }
    
    var navBarTitle: XCUIElement {
        return app.navigationBars.staticTexts["Add Ingredient"].firstMatch
    }
    
    var navBarDoneButton: XCUIElement {
        return app.navigationBars.buttons["Done"].firstMatch
    }
    
    var inputField: XCUIElement {
        return app.textFields.firstMatch
    }
    
    var reminderTextFirstLine: XCUIElement {
        return app.staticTexts["Reminder: You can swipe left on an ingredient"]
    }
    
    var reminderTextSecondLine: XCUIElement {
        return app.staticTexts[" in your list to remove it!"]
    }
    
    // Types ingredient in virtual keyboard
    func typeIngredient(ing: String){
        
        let ingredientToCharArray = ing.map( { String($0) } )
        
        for char in ingredientToCharArray {
            app.keys[char].tap()
        }
        
        navBarDoneButton.tap()
    }
    
    // Remove ingredients from list view and returns if successful or not
    func removeIngredient(ing: String, index: Int) -> Bool{
        app.tables.cells.element(boundBy: index).swipeLeft(velocity: 100.0)
        app.buttons["Delete"].firstMatch.tap()
        Thread.sleep(forTimeInterval: 3.0)
        return app.staticTexts[ing].exists
    }

}
