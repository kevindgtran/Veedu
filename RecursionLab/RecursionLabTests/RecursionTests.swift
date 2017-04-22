//
//  RecusionLabTests.swift
//  RecusionLabTests
//
//  Created by Wellington Moreno on 10/17/16.
//  Copyright © 2016 General Assembly. All rights reserved.
//

import XCTest
@testable import RecursionLab

class RecusionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testPrintFistNumbers() {
        // prints 1...13
        Recursion.printFirstNumbers(n: 13)
    }
    
    func testPrintFrom() {
        
        Recursion.printFrom(n: 12) // print 12, 11, 10....1
    }
    
    func testFibonacci() {
        XCTAssertTrue(Recursion.fibonacci(of: 0) == 1)
        XCTAssertTrue(Recursion.fibonacci(of: 1) == 1)
        XCTAssertTrue(Recursion.fibonacci(of: 2) == 2)
        XCTAssertTrue(Recursion.fibonacci(of: 3) == 3)
        XCTAssertTrue(Recursion.fibonacci(of: 4) == 5)
        XCTAssertTrue(Recursion.fibonacci(of: 5) == 8)
        XCTAssertTrue(Recursion.fibonacci(of: 6) == 13)
        XCTAssertTrue(Recursion.fibonacci(of: 7) == 21)
        XCTAssertTrue(Recursion.fibonacci(of: 8) == 34)
    }
    
    func testFactorial() {
        
        XCTAssertEqual(Recursion.factorial(of: 1), 1)
        XCTAssertEqual(Recursion.factorial(of: 2), 2)
        XCTAssertEqual(Recursion.factorial(of: 3), 6)
        XCTAssertEqual(Recursion.factorial(of: 4), 24)
        XCTAssertEqual(Recursion.factorial(of: 5), 24*5)
    }
    
    func testGCD() {
        
        XCTAssertEqual(Recursion.GCD(first: 8, second: 12), 4)
        XCTAssertEqual(Recursion.GCD(first: 8, second: 24), 8)
        XCTAssertEqual(Recursion.GCD(first: 8, second: 9), 1)
        XCTAssertEqual(Recursion.GCD(first: 4, second: 6), 2)
    }
}
