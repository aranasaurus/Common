import Foundation
import XCTest
@testable import Common

class DictionaryExtensionTests: XCTestCase {
    static let allTests = [
        ("testDictionaryCombination", testDictionaryCombination),
        ("testDictionaryOverwrite", testDictionaryOverwrite),
        ("testDictionaryFromArrayOfTuple", testDictionaryFromArrayOfTuple),
    ]
    
    func testDictionaryCombination() throws {
        let first = ["one": "1", "two": "2"]
        let second = ["three": "3", "four": "4"]
        
        let result = first + second
        
        XCTAssertEqual(
            result,
            ["one": "1", "two": "2", "three": "3", "four": "4"]
        )
    }
    
    func testDictionaryOverwrite() throws {
        let first = ["one": "1", "two": "2"]
        let second = ["two": "22", "three": "3", "four": "4"]
        
        let result = first + second
        
        XCTAssertEqual(
            result,
            ["one": "1", "two": "22", "three": "3", "four": "4"]
        )
    }
    
    func testDictionaryFromArrayOfTuple() throws {
        let tuple: [(String, String)] = [("one", "1"), ("two", "2"), ("three", "3"), ("four", "4")]
        
        let result = Dictionary(tuple)
        
        XCTAssertEqual(
            result,
            ["one": "1", "two": "2", "three": "3", "four": "4"]
        )
    }
}
