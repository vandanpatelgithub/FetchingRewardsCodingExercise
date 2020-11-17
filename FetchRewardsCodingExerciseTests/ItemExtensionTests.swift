//
//  ItemExtensionTests.swift
//  FetchRewardsCodingExerciseTests
//
//  Created by Vandan Patel on 11/17/20.
//

import XCTest
@testable import FetchRewardsCodingExercise

class ItemExtensionTests: XCTestCase {
    var mockItems = [
        Item(id: 1, listId: 1, name: nil),
        Item(id: 1, listId: 1, name: nil),
        Item(id: 1, listId: 1, name: nil),
        Item(id: 2, listId: 2, name: "item 3"),
        Item(id: 2, listId: 2, name: "item 2"),
        Item(id: 2, listId: 2, name: "item 1"),
        Item(id: 2, listId: 2, name: ""),
        Item(id: 2, listId: 2, name: "")
    ]
    
    func testRemoveEmptyOrNilNames() {
        let filteredItems = mockItems.removeEmptyOrNilNames()
        XCTAssertEqual(filteredItems.count, 3)
    }
    
    func testSortByItemNumber() {
        let filteredNames = mockItems.removeEmptyOrNilNames()
        let filteredItems = filteredNames.sortByItemNumber()
        XCTAssertEqual(filteredItems[0].name, "item 1")
    }
}
