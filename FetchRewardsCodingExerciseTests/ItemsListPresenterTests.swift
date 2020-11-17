//
//  ItemsListPresenterTests.swift
//  FetchRewardsCodingExerciseTests
//
//  Created by Vandan Patel on 11/17/20.
//

import XCTest
@testable import FetchRewardsCodingExercise

let mockItems = [
    Item(id: 1, listId: 1, name: ""),
    Item(id: 2, listId: 1, name: "item"),
    Item(id: 3, listId: 1, name: nil)
]

class ItemsListError: Error {}

class ItemsListPresenterTests: XCTestCase {

    let viewMock = ItemsVCMock()
    var presenter: ItemsListPresenter!
    
    override func setUpWithError() throws {
        super.setUp()
        presenter = ItemsListPresenter(view: viewMock)
    }

    override func tearDownWithError() throws {
        presenter = nil
        super.tearDown()
    }
    
    func testDidFetchItems() {
        presenter.didFetchItems(.success(mockItems))
        XCTAssertTrue(viewMock.numberOfTimesDisplayItemsCalled == 1)
        XCTAssertEqual(viewMock.groupedItems.count, 1)
    }
    
    func testDisplayError() {
        presenter.didFetchItems(.failure(ItemsListError()))
        XCTAssertEqual(viewMock.numberOfTimesDisplayErrorCalled, 1)
        XCTAssertEqual(viewMock.error, ItemsListError().localizedDescription)
    }
}

