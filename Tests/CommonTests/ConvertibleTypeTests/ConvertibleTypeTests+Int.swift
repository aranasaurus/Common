import Foundation
import XCTest
@testable import Common

extension ConvertibleTypeTests {
    func testInt() throws {
        let tests: [(type: ConvertibleType.Type, input: Any, expectedOutput: AnyEquatable?)] = [
            (Int.self,  "testing 1 2 3",    nil),
            (Int.self,  42,                 AnyEquatable(42)),
            (Int.self,  "42",               AnyEquatable(42)),
            (Int.self,  true,               AnyEquatable(1)),
            (Int.self,  false,              AnyEquatable(0)),
            (Int.self,  1.0,                AnyEquatable(1)),
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
