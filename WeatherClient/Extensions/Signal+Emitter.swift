//  Created by George Prokopenko on 04/12/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

// MARK: - Signal

public typealias SignalSubscriptionToken = Int

public class Signal<T> where T: Equatable {
    public typealias Listener = (T) -> Void
    public private(set) var value: T
    private var listeners = [SignalSubscriptionToken: Listener]()

    fileprivate init(_ emitter: Emitter<T>) {
        self.value = emitter.value
        emitter.emitterBlock = { [weak self] (value) in
            self?.value = value
            self?.listeners.values.forEach { $0(value) }
        }
    }

    /// method is not thread safe!
    @discardableResult
    public func addListener(skipCurrent: Bool = false, _ listener: @escaping Listener) -> SignalSubscriptionToken {
        let key = (listeners.keys.max() ?? 0) + 1
        listeners[key] = listener
        if !skipCurrent {
            listener(value)
        }
        return key
    }

    /// method is not thread safe!
    public func removeListener(_ token: SignalSubscriptionToken) {
        listeners[token] = nil
    }
}

// MARK: - Emitter

public class Emitter<T> where T: Equatable {

    fileprivate var emitterBlock: ((T) -> Void)?

    public private(set) lazy var signal: Signal<T> = {
        return Signal(self)
    }()

    public var value: T {
        didSet {
            if value != oldValue {
                emitterBlock?(value)
            }
        }
    }

    public init(_ value: T) {
        self.value = value
    }
}
