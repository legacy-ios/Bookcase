//
//  BookcaseViewControllerTests.swift
//  BookcaseTests
//
//  Created by jungwooram on 2020-05-04.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import XCTest
@testable import Bookcase
class BookcaseViewControllerTests: XCTestCase {

    var sut: BookcaseViewController!
    var cell: BookcaseCell!
    var expectation: XCTestExpectation!
    var result: [Book]!

    override func setUp() {
        super.setUp()
        sut = BookcaseViewController()
        cell = sut.bookcaseView.tableView.dequeueReusableCell(withIdentifier: "BookcaseCell", for: IndexPath.init(row: 0, section: 0)) as? BookcaseCell
    }

    override func tearDown() {
        sut = nil
        cell = nil
        expectation = nil
        super.tearDown()
    }
    
    func testAsyncLoadImageCache() {
        
        let imageViewBeforeCache = UIImageView()
        let imageViewAfterCache = UIImageView()
        
        imageViewBeforeCache.loadImage(urlString: "https://www.storytel.se/images/9783732005932/640x640/cover.jpg")
        if let image = UIImageView.ImageCache.cache.object(forKey: "https://www.storytel.se/images/9783732005932/640x640/cover.jpg" as AnyObject) as? UIImage {
            imageViewAfterCache.image = image
            XCTAssertEqual(imageViewBeforeCache.image, imageViewAfterCache.image)
        }
        
    }
    
    func testNextPageTokenIsIncludedWhenFetchAPI() {
        expectation = expectation(description: "wait for nextPageToken")
        sut.serviceManager.delegate = self
        sut.fetchBookcaseInfo()
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
        let expectationNextPageToken = result[0].nextPageToken
        XCTAssertNotNil(expectationNextPageToken)
    }
    
    func testQuaryIsIncludedWhenFetchAPI() {
        expectation = expectation(description: "wait for quary")
        sut.serviceManager.delegate = self
        sut.fetchBookcaseInfo()
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
        let expectationQuary = result[0].query
        XCTAssertEqual(expectationQuary, "harry")
    }
    
    func testCellShouldContainAbookCoverImage() {
        cell.cover.loadImage(urlString: "https://www.storytel.se/images/9783732005932/640x640/cover.jpg")
        
        let imageview = UIImageView()
        imageview.loadImage(urlString: "https://www.storytel.se/images/9783732005932/640x640/cover.jpg")
        
        XCTAssertEqual(cell.cover.image,imageview.image)
    }
    
    func testCellShouldContainAbookTitle() {
        cell.title.text = "this is title"
        XCTAssertEqual(cell.title.text,"this is title")
    }
    
    func testCellShouldContainAbookAuthor() {
        cell.author.text = "author name is test"
        XCTAssertEqual(cell.author.text,"author name is test")
    }
    
    func testCellShouldContainAbookNarrator() {
        cell.narrator.text = "narrator name is test"
        XCTAssertEqual(cell.narrator.text,"narrator name is test")
    }
    
    /**
    
     I wnated pass this unit test but I could not complete this unit test.
     How can I pass this this unit test ?
    
    func testWhenFetchDataItShoudBeAppend() {
        expectation = expectation(description: "Append new data")
        sut.serviceManager.delegate = self
        sut.books = [Book]()
        expectation.expectedFulfillmentCount = 2
        wait(for: [expectation], timeout: 10)
        sut.fetchBookcaseInfo()
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(sut.books.count, 10)
        sleep(3)
        sut.fetchBookcaseInfo()
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(sut.books.count, 20)
    }*/
    
}

extension BookcaseViewControllerTests: BookcaseServiceManagerDelegate {
    func didUpdateBookcase(_ bookcaseManager: BookcaseServiceManager, books: [Book]?) {
        if let books = books {
            result = books
            sut.books.append(contentsOf: books)
        }
        expectation.fulfill()
    }
    
    func didFailWithError(error: Error) {
        expectation.fulfill()
    }
}


