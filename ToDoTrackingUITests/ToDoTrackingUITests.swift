//
//  ToDoTrackingUITests.swift
//  ToDoTrackingUITests
//
//  Created by Daisha McCutcheon on 4/11/26.
//

import XCTest

final class ToDoTrackingUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    //start name with word "test:
    //validateTaskCompletedTest -> incorrect
    //testValidateTaskCompleted -> correct
    
    func testLaunchEnglish() {
        app.launchArguments = ["-AppleLanguages", "(en)"]
        app.launch()
        
        //search for accessibility id of the test
        let header = app.staticTexts[""]
        
        //verify that test is shown in correct language
        XCTAssertTrue(header.exists, "The test is not found in English")
    }
    
    func testLaunchThai() {
        app.launchArguments = ["-AppleLanguages", "(th)"]
        app.launch()
        
        //search for accessibility id of the test
        let header = app.staticTexts[""]
        
        //verify that test is shown in correct language
        XCTAssertTrue(header.exists, "The test is not found in Thai")
    }
    
    // create new task within a group
    func testCreateNewTask() {
        app.launch()
        
        // select a profile
        let selectedProfile = app.buttons["ProfileCard_Professor"] //ProfileCard_Professor
        XCTAssertTrue(selectedProfile.exists)
        selectedProfile.tap()
        
        let addGroup = app.buttons["AddGroupButton"] //AddGroupButton
        XCTAssertTrue(addGroup.exists)
        addGroup.tap()
        
        let nameField = app.textFields["GroupNameTextField"] //GroupNameTextField
        nameField.tap()
        nameField.typeText("Test Task 123")
        
        app.buttons["SaveGroupButton"].tap() //SaveGroupButton
        
        // Add task
        
    }
    
    
    
}
