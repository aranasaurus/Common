
public struct NeighborSequence<S: RandomAccessCollection>: Sequence, IteratorProtocol {
    public typealias Element = (previous: S.Iterator.Element?, current: S.Iterator.Element, next: S.Iterator.Element?)
    
    private let sequence: S
    private var currentIndex: S.Index
    
    init(sequence: S) {
        self.sequence = sequence
        self.currentIndex = sequence.startIndex
    }
    
    mutating public func next() -> Element? {
        guard self.currentIndex < self.sequence.endIndex else { return nil }
        
        let previousIndex = self.sequence.index(before: self.currentIndex)
        let nextIndex = self.sequence.index(after: self.currentIndex)
        defer { self.currentIndex = nextIndex }
        
        let previous: S.Iterator.Element? = (
            self.currentIndex == self.sequence.startIndex ?
            nil : self.sequence[previousIndex]
        )
        let next: S.Iterator.Element? = (
            nextIndex == self.sequence.endIndex ?
            nil : self.sequence[nextIndex]
        )
        
        return (previous: previous, current: self.sequence[self.currentIndex], next: next)
    }
}

extension RandomAccessCollection {
    public var neighbors: NeighborSequence<Self> {
        return NeighborSequence(sequence: self)
    }
}
