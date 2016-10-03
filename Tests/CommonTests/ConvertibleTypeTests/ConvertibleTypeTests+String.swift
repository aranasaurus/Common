import Foundation
import XCTest
@testable import Common

extension ConvertibleTypeTests {
    func testString() throws {
        let tests: [(type: ConvertibleType.Type, input: Any, expectedOutput: AnyEquatable)] = [
            (String.self,   "testing 1 2 3",    AnyEquatable("testing 1 2 3")),
            (String.self,   42,                 AnyEquatable("42")),
            (String.self,   true,               AnyEquatable("true")),
            (String.self,   1.0,                AnyEquatable("1.0")),
            ]
        
        for (type, input, expectedOutput) in tests {
            let output = try type.make(from: input)
            XCTAssertTrue(expectedOutput.equals(output), "\nINPUT: \(input) != \(output) : Expected: \(expectedOutput.value)")
        }
    }
}
