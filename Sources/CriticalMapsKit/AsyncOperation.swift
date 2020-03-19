//
//  AsyncOperation.swift
//  CriticalMaps
//
//  Created by Илья Глущук on 13/10/2019.
//  Copyright © 2019 Pokus Labs. All rights reserved.
//

import Foundation

class AsyncOperation: Operation {
    enum State: String {
        case ready, executing, finished

        fileprivate var keyPath: String {
            "is\(rawValue.capitalized)"
        }
    }

    override var isExecuting: Bool {
        state == .executing
    }

    override var isFinished: Bool {
        state == .finished
    }

    override var isAsynchronous: Bool {
        true
    }

    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }

    override func cancel() {
        super.cancel()
        state = .finished
    }

    override func start() {
        if isCancelled {
            state = .finished
            return
        }

        state = .executing
        main()
    }
}
