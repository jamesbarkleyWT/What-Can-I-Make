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
        XCTAssertTrue(addIngredientScreen.navBarCancelButton.exists)
        XCTAssertTrue(addIngredientScreen.navBarTitle.exists)
        XCTAssertTrue(addIngredientScreen.navBarDoneButton.exists)
        XCTAssertTrue(addIngredientScreen.inputField.exists)
        XCTAssertTrue(addIngredientScreen.reminderTextFirstLine.exists)
        XCTAssertTrue(addIngredientScreen.reminderTextSecondLine.exists)
    }
    
    func testAddSingleIngredient(){
        addIngredientScreen.inputField.tap()
        addIngredientScreen.typeIngredient(ing: ingredientOne)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientOne))
        
    }
    
    func testAddMultipleIngredient(){
        XCTAssertTrue(addIngredientScreen.inputField.waitForExistence(timeout: 5.0))
        addIngredientScreen.inputField.tap()
        
        // Add First Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientOne)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientOne))
        searchScreen.navBarAddButton.tap()
        addIngredientScreen.inputField.tap()
        
        
        // Add Second Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientTwo)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientTwo))
        searchScreen.navBarAddButton.tap()
        addIngredientScreen.inputField.tap()
        
        // Add Third Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientThree)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientThree))
    }
    
    func testRemoveIngredient(){
        XCTAssertTrue(addIngredientScreen.inputField.waitForExistence(timeout: 5.0))
        addIngredientScreen.inputField.tap()
        
        // Add First Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientOne)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientOne))
        searchScreen.navBarAddButton.tap()
        addIngredientScreen.inputField.tap()
        
        
        // Add Second Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientTwo)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientTwo))
        XCTAssertFalse(addIngredientScreen.removeIngredient(ing: ingredientTwo, index: 1))
        
    }
    
    func testRemoveMultipleIngredient(){
        XCTAssertTrue(addIngredientScreen.inputField.waitForExistence(timeout: 5.0))
        addIngredientScreen.inputField.tap()
        
        // Add First Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientOne)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientOne))
        searchScreen.navBarAddButton.tap()
        addIngredientScreen.inputField.tap()
        
        
        // Add Second Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientTwo)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientTwo))
        searchScreen.navBarAddButton.tap()
        addIngredientScreen.inputField.tap()
        
        // Add Third Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientThree)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientThree))
        
        
        XCTAssertFalse(addIngredientScreen.removeIngredient(ing: ingredientOne, index: 0))
        XCTAssertFalse(addIngredientScreen.removeIngredient(ing: ingredientTwo, index: 0))
        XCTAssertFalse(addIngredientScreen.removeIngredient(ing: ingredientThree, index: 0))
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    

}
