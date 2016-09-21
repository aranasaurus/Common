
/// Defines a set of options that can be used to determine the logical outcome of a predicate
public enum Operation {
    case and, or
    
    var function: (Bool, Bool) -> Bool {
        switch self {
        case .and: return { $0 && $1 }
        case .or: return { $0 || $1 }
        }
    }
}

public extension String {
    /// Determine if the receiver contains all the provided values
    public func contains(all values: [String]) -> Bool {
        return values.reduce(true) { result, value in
            return result && self.contains(value)
        }
    }
    
    /// Determine if the receiver contains any of the provided values
    public func contains(any values: [String]) -> Bool {
        return values.reduce(false) { result, value in
            return result || self.contains(value)
        }
    }
    
    /**
     Determine wether the receiver contains all of one set of values, any of another
     and the logical operation that joins them.
     
     - parameter all: All the values the receiver should contain
     - parameter operation: The logical operation to perform
     - parameter any: Any values the reciever should contain
     
     - returns: `true` if the receiver matches all the provided parameters, otherwise `false`
     */
    public func contains(all: [String], _ operation: Operation, any: [String]) -> Bool {
        return operation.function(self.contains(all: all), self.contains(any: any))
    }
}
