#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

public extension Collection where Index == Int {
    /// Returns a random element from the collection. It is a programmer error to call this on an empty collection.
    var randomElement: Self.Iterator.Element {
        guard !self.isEmpty else { fatalError() }

        let min = self.startIndex
        let max = self.endIndex - self.startIndex
        #if os(Linux)
            let index = Int(libc.random() % max) + min
        #else
            let index = Int(arc4random_uniform(UInt32(max))) + min
        #endif

        return self[index]
    }
}

