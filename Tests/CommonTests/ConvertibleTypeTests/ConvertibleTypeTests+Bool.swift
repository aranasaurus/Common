import Foundation
import XCTest
@testable import Common

extension ConvertibleTypeTests {
    func testBoolean() throws {
        let tests: [(type: ConvertibleType.Type, input: Any, expectedOutput: AnyEquatable)] = [
            (Bool.self, "t",        AnyEquatable(true)),
            (Bool.self, "true",     AnyEquatable(true)),
            (Bool.self, "TRUE",     AnyEquatable(true)),
            (Bool.self, "f",        AnyEquatable(false)),
            (Bool.self, "false",    AnyEquatable(false)),
            (Bool.self, "y",        AnyEquatable(true)),
            (Bool.self, "yes",      AnyEquatable(true)),
            (Bool.self, "n",        AnyEquatable(false)),
            (Bool.self, "no",       AnyEquatable(false)),
            (Bool.self, "0",        AnyEquatable(false)),
            (Bool.self, "1",        AnyEquatable(true)),
            (Bool.self, "3",        AnyEquatable(false)), //invalid
            (Bool.self, 0,          AnyEquatable(false)),
            (Bool.self, 1,          AnyEquatable(true)),
            (Bool.self, 42,         AnyEquatable(false)), //invalid
            (Bool.self, true,       AnyEquatable(true)),
            (Bool.self, false,      AnyEquatable(false)),
            (Bool.self, 1.0,        AnyEquatable(false)), //invalid
        ]
        
        for (type, input, expectedOutput) in tests {
            let output = try type.make(from: input)
            XCTAssertTrue(expectedOutput.equals(output), "\nINPUT: \(input) != \(output) : Expected: \(expectedOutput.value)")
        }
    }
}
