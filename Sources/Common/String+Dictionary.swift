import Foundation

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
