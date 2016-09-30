import Foundation

public extension Sequence {
    /**
     Groups the elements in a `Sequence` by the provided `condition`
     */
    public func grouped<T: Hashable>(by condition: (Iterator.Element) -> T) -> [T: [Iterator.Element]] {
        var result: [T: [Iterator.Element]] = [:]
        for item in self {
            let key = condition(item)
            var items = result[key] ?? []
            items.append(item)
            result[key] = items
        }
        return result
    }
}
