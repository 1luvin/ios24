//
//  z7Tests.swift
//  z7Tests
//

import XCTest
@testable import z7

final class z7Tests: XCTestCase {
    var vm: NotesViewModel!
    
    override func setUpWithError() throws {
        vm = NotesViewModel()
    }

    override func tearDownWithError() throws {
        vm = nil
    }

    func testEmptyNotes() {
        XCTAssertTrue(vm.notes.isEmpty)
    }
    
    func testAddNote() {
        vm.addNote("Test Note")
        XCTAssertEqual(vm.notes.count, 1)
        XCTAssertEqual(vm.notes.first?.text, "Test Note")
    }
    
    func testAddWhitespaceWithTextNote() {
        vm.addNote("   Test Note   ")
        XCTAssertEqual(vm.notes.count, 1)
        XCTAssertEqual(vm.notes.first?.text, "Test Note")
    }
    
    func testAddNewLineWithTextNote() {
        vm.addNote("Test Note\n")
        XCTAssertEqual(vm.notes.count, 1)
        XCTAssertEqual(vm.notes.first?.text, "Test Note")
    }
        
    func testAddEmptyNote() {
        vm.addNote("")
        XCTAssertEqual(vm.notes.count, 0)
    }
        
    func testAddWhitespaceNote() {
        vm.addNote("   ")
        XCTAssertEqual(vm.notes.count, 0)
    }
    
    func testAddNewLineNote() {
        vm.addNote("\n")
        XCTAssertEqual(vm.notes.count, 0)
    }
    
    func testRemoveNote() {
        vm.addNote("Test Note")
        vm.removeNote(at: 0)
        XCTAssertTrue(vm.notes.isEmpty)
    }
    
    func testFindNote() {
        vm.addNote("Test Note")
        let idx = vm.notes.firstIndex(where: { $0.text == "Test Note" })
        XCTAssertEqual(idx, 0)
    }
    
    func testFindNonExistingNote() {
        vm.addNote("Test Note")
        let idx = vm.notes.firstIndex(where: { $0.text == "Test" })
        XCTAssertEqual(idx, nil)
    }
    
    func testRemoveNoteOutOfBounds() {
        vm.removeNote(at: 0)
        XCTAssertEqual(vm.notes.count, 0)
    }
    
    func testMultipleNotes() {
        vm.addNote("Note 1")
        vm.addNote("Note 2")
        XCTAssertEqual(vm.notes.count, 2)
    }
    
    func testClearAllNotes() {
        vm.addNote("Note 1")
        vm.addNote("Note 2")
        vm.removeAllNotes()
        XCTAssertTrue(vm.notes.isEmpty)
    }
    
    func testNoteExists() {
        vm.addNote("Unique Note")
        XCTAssertTrue(vm.noteExists("Unique Note"))
    }
    
    func testNoteDoesNotExist() {
        XCTAssertFalse(vm.noteExists("Nonexistent Note"))
    }

}
