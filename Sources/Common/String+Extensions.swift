import Foundation

public protocol StringType {
    var string: String { get }
}
extension String: StringType {
    public var string: String { return self }
}

public extension String {
    public var lowerCamelCase: String {
        return self
            .components(separatedBy: ["_", " "])
            .enumerated()
            .reduce("") { (result: String, item: (index: Int, part: String)) in
                return result + (item.index == 0 ? item.part.lowercased() : item.part.capitalized)
        }
    }
    public var snakeCase: String {
        return self
            .components(separatedBy: ["_", " "])
            .joined(separator: "_")
    }
    public var screamingSnakeCase: String {
        return self.snakeCase.uppercased()
    }
}

public extension String {
    public func components(separatedBy separators: [String]) -> [String] {
        return separators.reduce([self]) { result, separator in
            return result.flatMap { $0.components(separatedBy: separator) }
        }
    }
}

public extension String {
    public func makeDictionary() -> [String: Any] {
        do {
            guard
                let data = self.data(using: .utf8),
                let json = try JSONSerialization.json(with: data)
                else { return [:] }
            
            return json
        }
        catch { return [:] }
    }
}

public extension String {
    public func withSuffix(_ suffix: String) -> String {
        guard !self.hasSuffix(suffix) else { return self }
        return "\(self)\(suffix)"
    }
    
    public func withPrefix(_ prefix: String) -> String {
        guard !self.hasPrefix(prefix) else { return self }
        return "\(prefix)\(self)"
    }
}
