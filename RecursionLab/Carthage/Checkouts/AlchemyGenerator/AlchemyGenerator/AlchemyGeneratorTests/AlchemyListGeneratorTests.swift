//
//  AlchemyListGeneratorTests.swift
//  AlchemyGenerator
//
//  Created by Wellington Moreno on 9/11/16.
//  Copyright © 2016 Sir Wellington. All rights reserved.
//

import AlchemyGenerator
import Foundation
import XCTest

class AlchemyListGeneratorTests: XCTestCase
{
    var iterations = 0
    var size = 0
    
    override func setUp()
    {
        iterations = AlchemyGenerator.integer(from: 10, to: 100)
        size = AlchemyGenerator.integer(from: 25, to: 200)
    }
    
    func testArray()
    {
        self.repeat()
        {
            let result = AlchemyGenerator.array(ofSize: size)
            {
                return AlchemyGenerator.hexString()
            }
            
            ensureNotEmpty(array: result)
            XCTAssertEqual(result.count, size)
        }
    }
    
    func testAnyElement()
    {
        self.repeat
        {
            let array = AlchemyGenerator.Arrays.ofAlphanumericString
            
            let element = AlchemyGenerator.anyOf(array)
            XCTAssertFalse(element == nil)
            XCTAssertTrue(array.contains(element!))
        }
    }
    
    fileprivate func `repeat`(_ operation: () -> ())
    {
        for _ in 1...iterations
        {
            operation()
        }
    }
}

//MARK: Test Lists Class
extension AlchemyListGeneratorTests
{
    func testArraysClass()
    {
        ensureNotEmpty(array: AlchemyGenerator.Arrays.ofAlphabeticString)
        ensureNotEmpty(array: AlchemyGenerator.Arrays.ofAlphanumericString)
        ensureNotEmpty(array: AlchemyGenerator.Arrays.ofString)
        ensureNotEmpty(array: AlchemyGenerator.Arrays.ofIntegers)
        ensureNotEmpty(array: AlchemyGenerator.Arrays.ofPositiveIntegers)
    }
    
    fileprivate func ensureNotEmpty<T>(array: [T])
    {
        XCTAssertFalse(array.isEmpty)
    }
}
