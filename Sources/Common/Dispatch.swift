public protocol CancellableDispatchOperation {
    func cancel() throws
}

extension Strand: CancellableDispatchOperation { }
    
public func inBackground(function: () -> Void) -> CancellableDispatchOperation {
    return try! Strand(function)
}
public func inBackground(try function: () throws -> Void, catch failure: (Error) -> Void) -> CancellableDispatchOperation {
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
