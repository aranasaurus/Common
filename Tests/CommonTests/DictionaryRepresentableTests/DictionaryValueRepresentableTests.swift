import Foundation
import XCTest
@testable import Common

enum StringEnum: String, DictionaryValueRepresentable {
    case foo, bar
}
enum IntEnum: Int, DictionaryValueRepresentable {
    case one = 1, two
}

class DictionaryValueRepresentableTests: XCTestCase {
    static let allTests = [
        ("testStringValue", testStringValue),
        ("testIntValue", testIntValue),
        ("testFloatValue", testFloatValue),
        ("testDoubleValue", testDoubleValue),
        ("testBoolValue", testBoolValue),
        ("testStringEnumValue", testStringEnumValue),
        ("testIntEnumValue", testIntEnumValue),
    ]
    
    func testStringValue() throws {
        guard
            let value = "foo".dictionaryValue as? String,
            value == "foo"
            else { return XCTFail() }
    }
    
    func testIntValue() throws {
        guard
            let value = 42.dictionaryValue as? Int,
            value == 42
            else { return XCTFail() }
    }
    
    func testFloatValue() throws {
        guard
            let value = (42.0 as Float).dictionaryValue as? Float,
            value == 42.0
            else { return XCTFail() }
    }
    
    func testDoubleValue() throws {
        guard
            let value = (42.0 as Double).dictionaryValue as? Double,
            value == 42.0
            else { return XCTFail() }
    }
    
    func testBoolValue() throws {
        guard
            let value = true.dictionaryValue as? Bool,
            value == true
            else { return XCTFail() }
    }
    
    func testStringEnumValue() throws {
        guard
            let value = StringEnum.bar.dictionaryValue as? String,
            value == "bar"
            else { return XCTFail() }
    }
    func testIntEnumValue() throws {
        guard
            let value = IntEnum.two.dictionaryValue as? Int,
            value == 2
            else { return XCTFail() }
    }
}
