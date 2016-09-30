
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
    
    /**
     Returns a substring of the receiver from the start to the given index.from
     If the end index is longer than the receiver the whole receiver is returned
     
     - parameter to: The index to stop at
     - returns: A new `String` instance that is the substring
     */
    func substring(to index: Int) -> String {
        let end = self.index(self.startIndex, offsetBy: index, limitedBy: self.endIndex) ?? self.endIndex
        return self.substring(to: end)
    }
    
    /**
     Returns a substring of the receiver from the given index to the end
     
     - parameter from: The index to start at
     - returns: A new `String` instance that is the substring
     */
    func substring(from: Int) -> String {
        return self.substring(from: self.index(self.startIndex, offsetBy: from))
    }
}
