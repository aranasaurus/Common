#if os(Linux)
import Glibc
#else
import Darwin.C
#endif

public protocol CancellableDispatchOperation {
    func cancel() throws
}

extension Strand: CancellableDispatchOperation { }
    
public func inBackground(function: () -> Void) -> CancellableDispatchOperation {
    return try! Strand(function)
}
public func inBackground(try function: @escaping () throws -> Void, catch failure: @escaping (Error) -> Void) -> CancellableDispatchOperation {
    let item = {
        do {
            try function()
        } catch let error {
            failure(error)
        }
    }
    return try! Strand(item)
}

public func keepAlive(until: () -> Bool = { false }) {
    while !until() {
        sleep(UInt32(0.5))
    }
}
