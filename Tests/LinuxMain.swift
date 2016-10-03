#if os(Linux)
    
import XCTest
@testable import Common
    
XCTMain([
    testCase(ConvertibleTypeTests.allTests),
    testCase(DictionaryExtensionTests.allTests),
    testCase(DictionaryRepresentableTests.allTests),
    testCase(DictionaryValueRepresentableTests.allTests),
    testCase(IdentifiableTests.allTests),
    testCase(IntExtensionTests.allTests),
])
    
#endif
