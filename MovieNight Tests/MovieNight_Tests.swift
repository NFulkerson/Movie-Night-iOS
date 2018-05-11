//
//  MovieNight_Tests.swift
//  MovieNight Tests
//
//  Created by Nathan on 5/9/18.
//  Copyright © 2018 Nathan Fulkerson. All rights reserved.
//

import XCTest
@testable import Movie_Night

// Example throwing method, from our application
func throwSomeError() throws {
    throw NSError(domain: "TestDomain", code: 1, userInfo: nil)
}

func plzNoThrowing() throws {

}

class MovieNight_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testThrowingMethods() {
        XCTAssertThrowsError(try throwSomeError())
        XCTAssertNoThrow(try plzNoThrowing())
    }

    func testGreaterValue() {
        let value = 10
        let expected = 8
        XCTAssertGreaterThan(
            value,
            expected
        )
    }
    
    func testExample() {
        XCTAssertEqual(7, 5+2)
    }
    
}
