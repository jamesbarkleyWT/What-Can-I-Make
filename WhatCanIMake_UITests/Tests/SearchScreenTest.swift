//
//  SearchScreenTest.swift
//  WhatCanIMake_UITests
//
//  Created by James Barkley on 7/21/21.
//

import XCTest

class SearchScreenTest: BaseTest {

    let homeScreen = HomeScreen()
    let searchScreen = SearchScreen()
    let addIngredientScreen = AddIngredientsScreen()
    let resultsScreen = ResultsScreen()
    
    let duplicateIngredient = "Bacon"
    
    override func setUp(){
        super.setUp()
        homeScreen.getStartedButton.tap()
    }
    
    func testVerifyPageElements(){
        XCTAssertTrue(searchScreen.navBarBackButton.exists)
        XCTAssertTrue(searchScreen.navBarTitle.exists)
        XCTAssertTrue(searchScreen.navBarAddButton.exists)
        XCTAssertTrue(searchScreen.welcomeTitle.exists)
        XCTAssertTrue(searchScreen.welcomeDetails.exists)
        XCTAssertTrue(searchScreen.searchButton.exists)
        
        // Verify Search Button is disabled since ingredient list is empty
        XCTAssertFalse(searchScreen.searchButton.isEnabled)
        XCTAssertTrue(searchScreen.viewSavedRecipesButton.exists)
    }
    
    func testBackButton(){
        XCTAssertTrue(searchScreen.navBarBackButton.exists)
        searchScreen.navBarBackButton.tap()
        
        XCTAssertTrue(homeScreen.appTitle.exists)
        
    }
    
    func testSearchIngredients(){
        
        // Verify Search Button is disabled since ingredient list is empty
        XCTAssertFalse(searchScreen.searchButton.isEnabled)
        
        XCTAssertTrue(searchScreen.navBarAddButton.waitForExistence(timeout: 5.0))
        searchScreen.navBarAddButton.tap()
        
        XCTAssertTrue(addIngredientScreen.inputField.waitForExistence(timeout: 5.0))
        
        
        // Add First Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientOne)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientOne))
        
        // Verify Search Button is enabled since ingredient list is now populated
        XCTAssertTrue(searchScreen.searchButton.isEnabled)
    
        searchScreen.navBarAddButton.tap()
        
        // Add Second Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientTwo)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientTwo))
        searchScreen.navBarAddButton.tap()
        
        
        // Add Third Ingredient
        addIngredientScreen.typeIngredient(ing: ingredientThree)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: ingredientThree))
        
        searchScreen.searchButton.tap()
        XCTAssertTrue(resultsScreen.resultsTitle.exists)
        XCTAssertTrue(resultsScreen.tipText.exists)
        Thread.sleep(forTimeInterval: 5.0)
        
        // Subtracting 3 since resultsScreen is a popover it is counting 13 because it is
        // including the 3 ingredients from the background page.
        XCTAssertEqual(resultsScreen.listCount - 3, 10)
    }
    

    
    func testDuplicateIngredientsAdded() {
        
        // Verify Search Button is disabled since ingredient list is empty
        XCTAssertFalse(searchScreen.searchButton.isEnabled)
        
        XCTAssertTrue(searchScreen.navBarAddButton.waitForExistence(timeout: 5.0))
        searchScreen.navBarAddButton.tap()
        
        XCTAssertTrue(addIngredientScreen.inputField.waitForExistence(timeout: 5.0))
        
        
        // Add Ingredient to list
        addIngredientScreen.typeIngredient(ing: duplicateIngredient)
        XCTAssertTrue(searchScreen.checkIngredientInListView(ing: duplicateIngredient))
        
        // Verify Search Button is enabled since ingredient list is now populated
        XCTAssertTrue(searchScreen.searchButton.isEnabled)
    
        searchScreen.navBarAddButton.tap()
        
        // Add Bacon again
        addIngredientScreen.typeIngredient(ing: duplicateIngredient)
        XCTAssertTrue(app.staticTexts["\(duplicateIngredient) already in list."].exists)
        
        Thread.sleep(forTimeInterval: 4)
        XCTAssertFalse(app.staticTexts["\(duplicateIngredient) already in list."].exists)
        
        
    }
    
    
    override func tearDown() {
        super.tearDown()
    }

}




