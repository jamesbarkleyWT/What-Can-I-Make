//
//  ResultsScreenTest.swift
//  WhatCanIMake_UITests
//
//  Created by James Barkley on 7/26/21.
//

import XCTest

class ResultsScreenTest: BaseTest {

    let homeScreen = HomeScreen()
    let searchScreen = SearchScreen()
    let addIngredientScreen = AddIngredientsScreen()
    let resultsScreen = ResultsScreen()

    let recipeName = "Chicken Vesuvio"
    let recipeServings = "4"
    let calories = "1057 Cal"
    let missingIng = "10"
    let dietLabels = "Peanut-Free, Tree-Nut-Free, Low-Carb"
    
    let invalidIngredient = "Chickenadilek"
    
    override func setUp(){
        super.setUp()
        homeScreen.getStartedButton.tap()
        searchScreen.navBarAddButton.tap()
    }
    
    func testCheckValidSearch() {
        
        // Create Search
        addIngredientScreen.typeIngredient(ing: ingredientOne)
        searchScreen.searchButton.tap()
        
        
        
        // Give time to get API response
        Thread.sleep(forTimeInterval: 6.0)
        let firstRecipe = resultsScreen.getFirstRecipe
        
        XCTAssertTrue(resultsScreen.resultsTitle.exists)
        XCTAssertTrue(resultsScreen.tipText.exists)
        XCTAssertTrue(app.staticTexts[recipeName].exists)
        XCTAssertTrue(app.staticTexts[recipeServings].exists)
        XCTAssertTrue(app.staticTexts[calories].exists)
        XCTAssertTrue(app.staticTexts[missingIng].exists)
        XCTAssertTrue(app.staticTexts[dietLabels].exists)
        
    }
    
    func testInvalidSearch() {
        // Create Search
        addIngredientScreen.typeIngredient(ing: invalidIngredient)
        searchScreen.searchButton.tap()
        
        // Give time to get API response
        Thread.sleep(forTimeInterval: 6.0)
        
        XCTAssertTrue(resultsScreen.resultsTitle.exists)
        XCTAssertTrue(resultsScreen.resultsTitle.exists)
        XCTAssertTrue(resultsScreen.tipText.exists)
        XCTAssertTrue(app.staticTexts["No Results"].exists)
        XCTAssertTrue(app.images["warning"].exists)
    }

}
