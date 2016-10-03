
struct AnyEquatable: Equatable {
    let equals: (Any) -> Bool
    let value: Any
    
    init<T: Equatable>(_ value: T) {
        self.value = value
        self.equals = { ($0 as! T) == value }
    }
}
func ==(lhs: AnyEquatable, rhs: AnyEquatable) -> Bool {
    return lhs.equals(rhs.value)
}
