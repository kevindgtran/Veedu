//
//  AlchemyGenerator+Arrays.swift
//  AlchemyGenerator
//
//  Created by Wellington Moreno on 9/11/16.
//  Copyright © 2016 Sir Wellington. All rights reserved.
//

import Foundation

//MARK: List Generation Classes
public extension AlchemyGenerator
{
    public class Arrays
    {
        public static var ofString: [String]
        {
            return AlchemyGenerator.array()
            {
                return AlchemyGenerator.alphanumericString()
            }
        }
        
        public static var ofAlphabeticString: [String]
        {
            return AlchemyGenerator.array() { AlchemyGenerator.alphabeticString() }
        }
        
        public static var ofAlphanumericString: [String]
        {
            return AlchemyGenerator.array() { AlchemyGenerator.alphanumericString() }
         }
        
        public static var ofIntegers: [Int]
        {
            return AlchemyGenerator.array(withCreator: AlchemyGenerator.anyInteger)
        }
        
        public static var ofPositiveIntegers: [Int]
        {
            return AlchemyGenerator.array(withCreator: AlchemyGenerator.positiveInteger)
        }
    }
}


//MARK: List Generation Methods
public extension AlchemyGenerator
{
    fileprivate static var defaultSize: Int
    {
        return integer(from: 5, to: 50)
    }
    
    static func array<T>(ofSize size: Int = defaultSize, withCreator creator: () -> T) -> [T]
    {
        guard size > 0 else { return [] }
        
        var result: [T] = []
        
        for _ in (1...size)
        {
            let newElement = creator()
            result.append(newElement)
        }
        
        return result
    }
    
    static func set<T>(withAttemptedSize size: Int = defaultSize, withCreator creator: () -> T) -> Set<T>
    {
        guard size > 0 else { return Set() }
        
        var result: Set<T> = Set()
        
        for _ in 1...size
        {
            let newElement = creator()
            result.insert(newElement)
        }
        
        return result
    }
    
    static func anyOf<T>(_ array: [T]) -> T?
    {
        guard !array.isEmpty else { return nil }
        
        let index = integer(from: 0, to: array.count)
        
        return array[index]
    }
}
