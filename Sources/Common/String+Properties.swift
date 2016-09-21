import Foundation

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
