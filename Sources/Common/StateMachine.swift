
/// An abstraction that represents an object that describes a set of states 
/// and the rules used for transitioning between them
public protocol StateRepresentable: Equatable {
    /// The event type that can trigger transitions
    associatedtype StateEvent
    
    /**
     Check if executing an event will result in a new state
     
     - parameter event: Event to trigger
     - returns: The new state if the event would result in one, otherwise nil
     */
    func transition(withEvent event: StateEvent) -> Self?
}

/// A read-only version of a `StateMachine`
public final class ReadOnlyStateMachine<State: StateRepresentable, Event> where State.StateEvent == Event {
    public typealias StateTransition = (State?, State) -> Void
    
    private let stateMachine: StateMachine<State, Event>
    
    fileprivate init(stateMachine: StateMachine<State, Event>) {
        self.stateMachine = stateMachine
    }
    
    public func observe<T: AnyObject>(_ observer: T, transition: @escaping (T) -> StateTransition) {
        self.stateMachine.observe(observer, transition: transition)
    }
}

/// StateMachine coordinates state transitions and notifies observers
public final class StateMachine<State: StateRepresentable, Event> where State.StateEvent == Event {
    public typealias StateTransition = (State?, State) -> Void
    
    //MARK: - Public Properties
    private(set) public var state: State {
        didSet { self.notifyObservers(from: oldValue, to: self.state) }
    }
    
    //MARK: - Private Properties
    private var observers = [WeakObserver<State, Event>]()
    
    //MARK: - Lifecycle
    public init(startingWith state: State) {
        self.state = state
    }
    
    //MARK: - Public
    public func transition(withEvent event: Event) {
        guard
            let result = self.state.transition(withEvent: event),
            result != self.state
            else { return print("Attempted invalid transition from \(self.state) with event: \(event)") }
        
        self.state = result
    }
    public func observe<T: AnyObject>(_ observer: T, transition: @escaping (T) -> StateTransition) {
        let observerWrapper = WeakObserver<State, Event>(observer: observer, transition: transition)
        self.observers.append(observerWrapper)
        transition(observer)(nil, self.state)
    }
    public var readOnly: ReadOnlyStateMachine<State, Event> {
        return ReadOnlyStateMachine(stateMachine: self)
    }
    
    //MARK: - Private
    private func notifyObservers(from oldState: State?, to newState: State) {
        self.observers = self.observers.filter { $0.observer != nil }
        self.observers.forEach { observer in
            if let object = observer.observer {
                observer.transition(object)(oldState, newState)
            }
        }
    }
}

final private class WeakObserver<State: StateRepresentable, Event> where State.StateEvent == Event {
    typealias StateTransition = (State?, State) -> Void
    
    weak var observer: AnyObject?
    let transition: (AnyObject) -> StateTransition
    
    init<T: AnyObject>(observer: T, transition: @escaping (T) -> StateTransition) {
        self.observer = observer as AnyObject
        self.transition = { obj in
            guard let obj = obj as? T else { fatalError() }
            return { from, to in
                transition(obj)(from, to)
            }
        }
    }
}
