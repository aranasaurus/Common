import Foundation
import XCTest
@testable import Common

struct AnyEquatable: Equatable {
    let equals: (Any) -> Bool
    let value: Any
    
    init<T: Equatable>(value: T) {
        self.value = value
        self.equals = { ($0 as! T) == value }
    }
}
func ==(lhs: AnyEquatable, rhs: AnyEquatable) -> Bool {
    return lhs.equals(rhs.value)
}

class ConvertibleTypeTests: XCTestCase {
    func testBoolean() throws {
        let tests: [(type: ConvertibleType.Type, input: Any, expectedOutput: AnyEquatable)] = [
            (Bool.self, "t",        AnyEquatable(value: true)),
            (Bool.self, "true",     AnyEquatable(value: true)),
            (Bool.self, "TRUE",     AnyEquatable(value: true)),
            (Bool.self, "f",        AnyEquatable(value: false)),
            (Bool.self, "false",    AnyEquatable(value: false)),
            (Bool.self, "y",        AnyEquatable(value: true)),
            (Bool.self, "yes",      AnyEquatable(value: true)),
            (Bool.self, "n",        AnyEquatable(value: false)),
            (Bool.self, "no",       AnyEquatable(value: false)),
            (Bool.self, "0",        AnyEquatable(value: false)),
            (Bool.self, "1",        AnyEquatable(value: true)),
            (Bool.self, "3",        AnyEquatable(value: false)), //invalid
            (Bool.self, 0,          AnyEquatable(value: false)),
            (Bool.self, 1,          AnyEquatable(value: true)),
            (Bool.self, 42,         AnyEquatable(value: false)), //invalid
            (Bool.self, true,       AnyEquatable(value: true)),
            (Bool.self, false,      AnyEquatable(value: false)),
            (Bool.self, 1.0,        AnyEquatable(value: false)), //invalid
            ]
        
        for (type, input, expectedOutput) in tests {
            let output = try type.make(from: input)
            XCTAssertTrue(expectedOutput.equals(output), "\nINPUT: \(input) != \(output) : Expected: \(expectedOutput.value)")
        }
    }
    
    func testString() throws {
        let tests: [(type: ConvertibleType.Type, input: Any, expectedOutput: AnyEquatable)] = [
            (String.self,   "testing 1 2 3",    AnyEquatable(value: "testing 1 2 3")),
            (String.self,   42,                 AnyEquatable(value: "42")),
            (String.self,   true,               AnyEquatable(value: "true")),
            (String.self,   1.0,                AnyEquatable(value: "1.0")),
            ]
        
        for (type, input, expectedOutput) in tests {
            let output = try type.make(from: input)
            XCTAssertTrue(expectedOutput.equals(output), "\nINPUT: \(input) != \(output) : Expected: \(expectedOutput.value)")
        }
    }
    
    func testInt() throws {
        let tests: [(type: ConvertibleType.Type, input: Any, expectedOutput: AnyEquatable?)] = [
            (Int.self,  "testing 1 2 3",    nil),
            (Int.self,  42,                 AnyEquatable(value: 42)),
            (Int.self,  "42",               AnyEquatable(value: 42)),
            (Int.self,  true,               AnyEquatable(value: 1)),
            (Int.self,  false,              AnyEquatable(value: 0)),
            (Int.self,  1.0,                AnyEquatable(value: 1)),
            ]
        
        for (type, input, expectedOutput) in tests {
            do {
                let output = try type.make(from: input)
                XCTAssertTrue(expectedOutput!.equals(output), "\nINPUT: \(input) != \(output) : Expected: \(expectedOutput!.value)")
            } catch {
                if (expectedOutput != nil) { XCTFail() }
            }
        }
    }
    
    func testFloat() throws {
        let tests: [(type: ConvertibleType.Type, input: Any, expectedOutput: AnyEquatable?)] = [
            (Float.self,  "testing 1 2 3",    nil),
            (Float.self,  42,               AnyEquatable(value: 42.0 as Float)),
            (Float.self,  "42",             AnyEquatable(value: 42.0 as Float)),
            (Float.self,  true,             AnyEquatable(value: 1.0 as Float)),
            (Float.self,  false,            AnyEquatable(value: 0.0 as Float)),
            (Float.self,  1.0 as Float,     AnyEquatable(value: 1.0 as Float)),
            (Float.self,  1.0 as Double,    AnyEquatable(value: 1.0 as Float)),
            ]
        
        for (type, input, expectedOutput) in tests {
            do {
                let output = try type.make(from: input)
                XCTAssertTrue(expectedOutput!.equals(output), "\nINPUT: \(input) != \(output) : Expected: \(expectedOutput!.value)")
            } catch {
                if (expectedOutput != nil) { XCTFail() }
            }
        }
    }
    
    func testDouble() throws {
        let tests: [(type: ConvertibleType.Type, input: Any, expectedOutput: AnyEquatable?)] = [
            (Double.self,  "testing 1 2 3",    nil),
            (Double.self,  42,               AnyEquatable(value: 42.0 as Double)),
            (Double.self,  "42",             AnyEquatable(value: 42.0 as Double)),
            (Double.self,  true,             AnyEquatable(value: 1.0 as Double)),
            (Double.self,  false,            AnyEquatable(value: 0.0 as Double)),
            (Double.self,  1.0 as Float,     AnyEquatable(value: 1.0 as Double)),
            (Double.self,  1.0 as Double,    AnyEquatable(value: 1.0 as Double)),
            ]
        
        for (type, input, expectedOutput) in tests {
            do {
                let output = try type.make(from: input)
                XCTAssertTrue(expectedOutput!.equals(output), "\nINPUT: \(input) != \(output) : Expected: \(expectedOutput!.value)")
            } catch {
                if (expectedOutput != nil) { XCTFail() }
            }
        }
    }
}
