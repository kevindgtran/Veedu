//
//  AlchemyGeneratorStringTests.swift
//  AlchemyGenerator
//
//  Created by Wellington Moreno on 9/10/16.
//  Copyright © 2016 Sir Wellington. All rights reserved.
//

import AlchemyGenerator
import Foundation
import XCTest

class AlchemyStringGeneratorTests: XCTestCase
{
    fileprivate var size: Int = 0
    fileprivate var iterations = 10
    
    private let alphabeticalCharacters: [Character] =
    {
        let lowerCased = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z".components(separatedBy: ",")
        
        let upperCased = lowerCased.map() { $0.uppercased() }
        
        let combined = lowerCased + upperCased
        return combined.map() { $0.characters.first! }
    }()
    
    private let numericCharacters: [Character] =
    {
        var numeric: [Character] = []
        for i in 0...9
        {
            numeric.append(Character.init("\(i)"))
        }
        return numeric
    }()
    
    private var alphanumericCharacters: [Character]
    {
        return alphabeticalCharacters + numericCharacters
    }
    
    private let hexCharacters: [Character] =
    {
       let characters = "0123456789ABCDEF"
        return Array(characters.characters)
    }()
    
    override func setUp()
    {
        size = AlchemyGenerator.integer(from: 10, to: 100)
        iterations = AlchemyGenerator.integer(from: 10, to: 100)
    }
    
    func testNumericString()
    {
        let string = AlchemyGenerator.numericString(ofSize: size)
        XCTAssertEqual(string.characters.count, size)
    }
    
    func testAlphabeticalString()
    {
        for _ in (1...iterations)
        {
            let result = AlchemyGenerator.alphabeticString(ofSize: size)
            XCTAssertEqual(result.characters.count, size)
            
            ensure(string: result, areCharactersIn: alphabeticalCharacters)
        }
    }
    
    func testAlphabeticalStringWithBadSize()
    {
        for _ in (1...iterations)
        {
            let badSize = AlchemyGenerator.integer(from: -10, to: 0)
            let result = AlchemyGenerator.alphabeticString(ofSize: badSize)
            XCTAssertTrue(result.isEmpty)
        }
    }
    
    func testAlphanumericString()
    {
        for _ in (1...iterations)
        {
            let result = AlchemyGenerator.alphanumericString(ofSize: size)
            XCTAssertEqual(result.characters.count, size)
            
            ensure(string: result, areCharactersIn: alphanumericCharacters)
        }
    }
    
    func testAlphanumericStringWithBadSize()
    {
        for _ in (1...iterations)
        {
            let badSize = AlchemyGenerator.integer(from: -10, to: 0)
            let result = AlchemyGenerator.alphanumericString(ofSize: badSize)
            
            XCTAssertTrue(result.isEmpty)
        }
    }
    
    func testHexStrings()
    {
        for _ in (1...iterations)
        {
            let result = AlchemyGenerator.hexString(ofSize: size)
            XCTAssertEqual(result.characters.count, size)
            
            ensure(string: result, areCharactersIn: hexCharacters)
        }
    }
    
    func testUUID()
    {
        self.repeat()
        {
            let result = AlchemyGenerator.uuidString()
            let uuid = UUID.init(uuidString: result)
            XCTAssertNotNil(uuid)
        }
    }
    
    func testStringFromList()
    {
        var strings: [String] = []
        
        for _ in 1...size
        {
            strings.append(AlchemyGenerator.Strings.alphabetic)
        }
        
        self.repeat()
        {
            let result = AlchemyGenerator.stringFromList(strings)
            XCTAssertTrue(strings.contains(result))
        }
    }
    
    private func ensure(string: String, areCharactersIn set: [Character])
    {
        for character in string.characters
        {
            XCTAssert(set.contains(character), "Character \(character) is not in the expected set: \(set)")
        }
    }
    
    private func `repeat`(_ operation: () -> ())
    {
        for _ in (1...iterations)
        {
            operation()
        }
    }
}

//MARK: Test Strings class
extension AlchemyStringGeneratorTests
{
    func testStringsClass()
    {
        for _ in (1...iterations)
        {
            checkNotEmpty(AlchemyGenerator.Strings.alphabetic)
            checkNotEmpty(AlchemyGenerator.Strings.alphanumeric)
            checkNotEmpty(AlchemyGenerator.Strings.hex)
            checkNotEmpty(AlchemyGenerator.Strings.numeric)

        }
    
    }
    
    func checkNotEmpty(_ string: String)
    {
        XCTAssertTrue(!string.isEmpty)
    }
}
