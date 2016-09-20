import Foundation

/// An abstraction that represents a `String`
/// essentially a small hack used in some of the Vapor related conversions
/// Will be removed once the conversions aren't required
public protocol StringType {
    var string: String { get }
}
extension String: StringType {
    public var string: String { return self }
}

public extension String {
    /// Return the current `String` in lowerCamelCase
    public var lowerCamelCase: String {
        return self
            .components(separatedBy: ["_", " "])
            .enumerated()
            .reduce("") { (result: String, item: (index: Int, part: String)) in
                return result + (item.index == 0 ? item.part.lowercased() : item.part.capitalized)
        }
    }
    
    /// Return the current `String` in snake_case
    public var snakeCase: String {
        return self
            .components(separatedBy: ["_", " "])
            .joined(separator: "_")
            .lowercased()
    }
    
    /// Return the current `String` in SCREAMING_SNAKE_CASE
    public var screamingSnakeCase: String {
        return self.snakeCase.uppercased()
    }
}

public extension String {
    /// Split the current string into components seperated by multiple separators
    public func components(separatedBy separators: [String]) -> [String] {
        return separators.reduce([self]) { result, separator in
            return result.flatMap { $0.components(separatedBy: separator) }
        }
    }
}

public extension String {
    /// Create a json `[String: Any]` from the current `String`
    public func makeDictionary() -> [String: Any] {
        do {
            guard let data = self.data(using: .utf8) else { return [:] }
            return try JSONSerialization.json(with: data)
        }
        catch { return [:] }
    }
}

public extension String {
    /// Return the current `String` ensuring it has a required suffix
    public func withSuffix(_ suffix: String) -> String {
        guard !self.hasSuffix(suffix) else { return self }
        return "\(self)\(suffix)"
    }
    
    /// Return the current `String` ensuring it has a required prefix
    public func withPrefix(_ prefix: String) -> String {
        guard !self.hasPrefix(prefix) else { return self }
        return "\(prefix)\(self)"
    }
}

public extension String {
    /// Determine if the receiver is prefixed with one of the provided options
    public func hasPrefix(options: [String]) -> Bool {
        for option in options where self.hasPrefix(option) {
            return true
        }
        return false
    }
    
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
