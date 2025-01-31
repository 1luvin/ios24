//
//  z7UITests.swift
//  z7UITests
//

import XCTest

final class z7UITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddingNote() {
        let textField = app.textFields["Enter note"]
        textField.tap()
        textField.typeText("UI Test Note")
        
        app.buttons["Add Note"].tap()
        XCTAssertTrue(app.staticTexts["UI Test Note"].exists)
    }
    
    func testDeletingNote() {
        let textField = app.textFields["Enter note"]
        textField.tap()
        textField.typeText("Note to Delete")
        
        app.buttons["Add Note"].tap()
        let deleteButton = app.buttons["Delete"].firstMatch
        deleteButton.tap()
        XCTAssertFalse(app.staticTexts["Note to Delete"].exists)
    }
    
    func testClearAllNotes() {
        let textField = app.textFields["Enter note"]
        textField.tap()
        textField.typeText("Note 1")
        app.buttons["Add Note"].tap()
        
        textField.tap()
        textField.typeText("Note 2")
        app.buttons["Add Note"].tap()
        
        app.buttons["Clear All"].tap()
        XCTAssertFalse(app.staticTexts["Note 1"].exists)
        XCTAssertFalse(app.staticTexts["Note 2"].exists)
    }
    
}
