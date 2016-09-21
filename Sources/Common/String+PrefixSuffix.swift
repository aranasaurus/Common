
public extension String {
    /// Determine if the receiver is prefixed with one of the provided options
    public func prefix(any values: [String]) -> Bool {
        return values.reduce(false) { result, value in
            return result || self.hasPrefix(value)
        }
    }
    
    /// Determine if the receiver is suffixed with one of the provided options
    public func suffix(any values: [String]) -> Bool {
        return values.reduce(false) { result, value in
            return result || self.hasSuffix(value)
        }
    }
}

public extension String {
    /// Return the current `String` ensuring it has a required suffix
    public func with(suffix: String) -> String {
        guard !self.hasSuffix(suffix) else { return self }
        return "\(self)\(suffix)"
    }
    
    /// Return the current `String` ensuring it has a required prefix
    public func with(prefix: String) -> String {
        guard !self.hasPrefix(prefix) else { return self }
        return "\(prefix)\(self)"
    }
}
