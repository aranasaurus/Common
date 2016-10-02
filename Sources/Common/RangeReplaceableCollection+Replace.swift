
public extension RangeReplaceableCollection {
    /**
     Finds the first item matching a given condition with the provided replacement
     */
    public func replaceFirst(matching condition: (Iterator.Element) throws -> Bool, with newItem: Iterator.Element) rethrows -> Self {
        guard let itemIndex = try self.index(where: condition) else { return self }
        
        var items = self
        items.remove(at: itemIndex)
        items.insert(newItem, at: itemIndex)
        return items
    }
}
