//
//  SavedRecipeScreenTest.swift
//  WhatCanIMake_UITests
//
//  Created by James Barkley on 7/26/21.
//

import XCTest

class SavedRecipeScreenTest: BaseTest {

    let homeScreen = HomeScreen()
    let searchScreen = SearchScreen()
    let addIngredientScreen = AddIngredientsScreen()
    let resultsScreen = ResultsScreen()
    let savedRecipeScreen = SavedRecipesScreen()

    
    
    override func setUp(){
        super.setUp()
        homeScreen.getStartedButton.tap()
        
    }
    
    // Using the numbering naming convention so tests run in order since
    // test03 depends on test02 running to completion first.
    
    func test01VerifyElements(){
        
        searchScreen.viewSavedRecipesButton.tap()
        XCTAssertTrue(savedRecipeScreen.listCount == 0)
        XCTAssertTrue(savedRecipeScreen.savedRecipeTitle1.exists)
        XCTAssertTrue(savedRecipeScreen.savedRecipeTitle2.exists)
        XCTAssertTrue(savedRecipeScreen.savedIcon.exists)
        XCTAssertTrue(savedRecipeScreen.tipText.exists)
        
    }
    
    func test02AddToSavedList(){
        
        // Create Search
        searchScreen.navBarAddButton.tap()
        addIngredientScreen.typeIngredient(ing: ingredientOne)
        searchScreen.searchButton.tap()
        
        
        // Give time to get API response
        Thread.sleep(forTimeInterval: 6.0)
        
        // Grab first recipe from response
        let firstRecipe = resultsScreen.getFirstRecipe
        
        XCTAssertTrue(resultsScreen.resultsTitle.exists)
        XCTAssertTrue(resultsScreen.tipText.exists)
        
        
        // Click Save Button
        firstRecipe.buttons.matching(identifier: "save").firstMatch.tap()
    }
    
    func test03SavedRecipe() {
        
        searchScreen.viewSavedRecipesButton.tap()
        
        XCTAssertTrue(savedRecipeScreen.listCount == 1)
        XCTAssertTrue(app.staticTexts["Chicken Vesuvio"].exists)
        
        
        // Remove Saved Ingredient
        XCTAssertFalse(savedRecipeScreen.removeSavedRecipe(ing: "Chicken Vesuvio", index: 0))
        
        XCTAssertTrue(savedRecipeScreen.listCount == 0)
        XCTAssertFalse(app.staticTexts["Chicken Vesuvio"].exists)
    }
    
    

}
