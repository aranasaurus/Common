
public extension String {
    /// Split the current string into components seperated by multiple separators
    public func components(separatedBy separators: [String]) -> [String] {
        return separators.reduce([self]) { result, separator in
            return result.flatMap { $0.components(separatedBy: separator) }
        }
    }
}

public extension String {
    /**
     Returns the receiver with the provided prefix removed if found.
     also, optionally, removes any additional leading whitespace
     
     - parameter prefix: The prefix to remove from the receiver
     - parameter dropTrailingWhitespace: If `true` removes andy additionaly leading whitespace after `prefix`
     - returns: The receiver with `prefix` and, optionally, leading whitespace removed
     */
    public func remove(prefix: String, dropTrailingWhitespace: Bool = true) -> String {
        guard self.hasPrefix(prefix) else { return self }
        
        var result = self.substring(from: prefix.endIndex)
        while result.hasPrefix(" ") {
            result = result.substring(from: result.index(after: result.startIndex))
        }
        
        return result
    }
}

public extension String {
    /**
     Returns a substring of the receiver from the first `Character` up to the first found instance of the provided `Character`
     
     - parameter to: The `Character` to look for
     - returns: If the `Character` was found the new substring, otherwise `nil`
     */
    public func substring(to value: Character) -> String? {
        guard let index = self.characters.index(of: value) else { return nil }
        return self.substring(to: index)
    }
}
