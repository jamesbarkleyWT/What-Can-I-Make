//
//  AddIngredientScreenTest.swift
//  WhatCanIMake_UITests
//
//  Created by James Barkley on 7/21/21.
//

import XCTest

class AddIngredientScreenTest: BaseTest {

    let homeScreen = HomeScreen()
    let searchScreen = SearchScreen()
    let addIngredientScreen = AddIngredientsScreen()
    let resultsScreen = ResultsScreen()

    
    
    override func setUp(){
        super.setUp()
        homeScreen.getStartedButton.tap()
        searchScreen.navBarAddButton.tap()
    }
    
    func testVerifyPageElements(){
        XCTAssertTrue(addIngredientScreen.navBarTitle.exists)
        XCTAssertTrue(addIngredientScreen.navBarDoneButton.exists)
        XCTAssertTrue(addIngredientScreen.inputField.exists)
        XCTAssertTrue(addIngredientScreen.reminderTextFirstLine.exists)
        XCTAssertTrue(addIngredientScreen.reminderTextSecondLine.exists)
    }
    
    func testAddSingleIngredient(){
        
        addIngredientScreen.typeIngredient(ing: ingredientOne)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientOne))
        
    }
    
    func testAddingNothing(){
        
        addIngredientScreen.navBarDoneButton.tap()
        XCTAssertTrue(app.staticTexts["You entered nothing."].exists)
    }
    
    func testAddMultipleIngredients(){
        XCTAssertTrue(addIngredientScreen.inputField.waitForExistence(timeout: 5.0))
        
        
        // Add First Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientOne)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientOne))
        searchScreen.navBarAddButton.tap()
        
        
        
        // Add Second Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientTwo)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientTwo))
        searchScreen.navBarAddButton.tap()
        
        
        // Add Third Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientThree)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientThree))
    }
    
    func testRemoveIngredient(){
        XCTAssertTrue(addIngredientScreen.inputField.waitForExistence(timeout: 5.0))
        
        
        // Add First Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientOne)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientOne))
        
        // Search Button should now be enabled after adding ingredient
        XCTAssertTrue(searchScreen.searchButton.isEnabled)
        
        searchScreen.navBarAddButton.tap()
        
        
        
        // Add Second Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientTwo)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientTwo))
        XCTAssertFalse(addIngredientScreen.removeIngredient(ing: ingredientTwo, index: 1))
        
        // Search Button should be disabled after removing only ingredient
        XCTAssertFalse(searchScreen.searchButton.isEnabled)
        
    }
    
    func testRemoveMultipleIngredient(){
        XCTAssertTrue(addIngredientScreen.inputField.waitForExistence(timeout: 5.0))
        
        
        // Add First Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientOne)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientOne))
        searchScreen.navBarAddButton.tap()
        
        
        // Search Button should be enabled
        XCTAssertTrue(searchScreen.searchButton.isEnabled)
        
        
        // Add Second Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientTwo)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientTwo))
        
        // Search Button should still be enabled
        XCTAssertTrue(searchScreen.searchButton.isEnabled)
        
        searchScreen.navBarAddButton.tap()
        
        
        // Add Third Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientThree)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientThree))
        
        // Search Button should still be enabled
        XCTAssertTrue(searchScreen.searchButton.isEnabled)
        
        
        // Deleting ingredients and verifying they are no longer in list as well
        // as making sure the Search button is still enabled
        XCTAssertFalse(addIngredientScreen.removeIngredient(ing: ingredientOne, index: 0))
        XCTAssertTrue(searchScreen.searchButton.isEnabled)
        
        XCTAssertFalse(addIngredientScreen.removeIngredient(ing: ingredientTwo, index: 0))
        XCTAssertTrue(searchScreen.searchButton.isEnabled)
        
        XCTAssertFalse(addIngredientScreen.removeIngredient(ing: ingredientThree, index: 0))
        XCTAssertTrue(searchScreen.searchButton.isEnabled)
        
        // Search Button should be disabled after removing all ingredients
        XCTAssertFalse(searchScreen.searchButton.isEnabled)
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    

}
