//
//  BookcaseServiceManagerTests.swift
//  BookcaseTests
//
//  Created by jungwooram on 2020-05-04.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import XCTest
@testable import Bookcase

class BookcaseServiceManagerTests: XCTestCase {

    var sut: BookcaseServiceManager!
    var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        sut = BookcaseServiceManager()
    }

    override func tearDown() {
        sut = nil
        expectation = nil
        super.tearDown()
    }
    
    func testModelForParsingJsonFromServer(){
        guard let url = URL(string: "https://api.storytel.net/search?query=harry") else {
            XCTFail()
            return
        }
        let decoder = JSONDecoder()
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            do{
                let decodedData = try decoder.decode(BookData.self, from: data!)
                XCTAssertEqual(decodedData.items[0].title, "Scary Harry: Fledermaus frei Haus")
                XCTAssertEqual(decodedData.items[0].cover.url, "https://www.storytel.se/images/9783732005932/640x640/cover.jpg")
            } catch{
                XCTFail(error.localizedDescription)
            }
        }.resume()
    }
    
    func testBookcaseServiceManagerDelegate() {
        expectation = expectation(description: "Wait for delegate")
        sut.delegate = self
        sut.fetchBookcaseInfo(nextPageToken: nil)
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
        XCTAssert(true, "Pass")
    }
   
}

extension BookcaseServiceManagerTests: BookcaseServiceManagerDelegate {
    func didUpdateBookcase(_ bookcaseManager: BookcaseServiceManager, books: [Book]?) {
        expectation.fulfill()
    }
    
    func didFailWithError(error: Error) {
        expectation.fulfill()
    }
}



