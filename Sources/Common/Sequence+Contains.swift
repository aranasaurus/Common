
extension Sequence where Iterator.Element: Equatable {
    /// Determine if the receiver contains all the provided values
    public func contains(all values: [Iterator.Element]) -> Bool {
        return values.reduce(true) { result, value in
            return result && self.contains(value)
        }
    }
    
    /// Determine if the receiver contains any of the provided values
    public func contains(any values: [Iterator.Element]) -> Bool {
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
    public func contains(all: [Iterator.Element], _ operation: Operation, any: [Iterator.Element]) -> Bool {
        return operation.function(self.contains(all: all), self.contains(any: any))
    }
}
