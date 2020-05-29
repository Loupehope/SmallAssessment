import Foundation


@available(iOS, deprecated, message: "use Collection instead")
protocol Container: Equatable where T: Equatable {
    associatedtype T: AnyObject
    
    var head: T? { get }
    var tail: T? { get }
    
    func pop() -> T?
    
    func push(_ element: T)
    
    subscript(index: Int) -> T? { get }
}

typealias AnyEquatableObject = AnyObject & Equatable

protocol SubscriptSafe {
    associatedtype T
    
    subscript(safe index: Int) -> T? { get }
}

extension Array: SubscriptSafe {
    subscript(safe index: Int) -> Element? {
        (0..<count).contains(index) ? self[index] : nil
    }
}

typealias AnyHashableObject = AnyObject & Hashable

struct Stack<Data: AnyHashableObject>: Hashable {
    private var elements: [Data] = []
    
    var head: Data? {
        elements.first
    }
    
    var tail: Data? {
        elements.last
    }
    
    mutating func pop() -> Data? {
        elements.removeLast()
    }
    
    mutating func push(_ element: Data) {
        elements.append(element)
    }
    
    subscript(index: Int) -> Data? {
        elements[safe: index]
    }
}

@available(swift 4.2)
final class Storage<Data: Container & AnyObject>: Container {
    private var elements: [Data] = []
    
    var head: Data? {
        elements.first
    }
    
    var tail: Data? {
        elements.last
    }
    
    func pop() -> Data? {
        elements.removeLast()
    }
    
    func push(_ element: Data) {
        elements.append(element)
    }
    
    subscript(index: Int) -> Data? {
        elements[safe: index]
    }
}

extension Storage {
    static func == (lhs: Storage<Data>, rhs: Storage<Data>) -> Bool {
        lhs.elements == rhs.elements
    }
}

typealias CustomStack<T: AnyHashableObject> = Stack<T>

