import Combine

public extension Future {
    /// Run async operation as Publisher
    /// - Parameter operation: Operation to be run
    convenience init(operation: @escaping () async throws -> Output) where Failure == Error {
        self.init { promise in
            Task {
                do {
                    try await promise(.success(operation()))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }

    /// Run async operation as Publisher
    /// - Parameter operation: Operation to be run
    convenience init(operation: @escaping () async -> Result<Output, Failure>) {
        self.init { promise in
            Task { promise(await operation()) }
        }
    }

    /// Run async operation as Publisher
    /// - Parameter operation: Operation to be run
    convenience init(operation: @escaping () async -> Output) where Failure == Never {
        self.init { promise in
            Task { promise(.success(await operation())) }
        }
    }
}

public extension AnyPublisher {
    /// Run async operation as Publisher
    /// - Parameter operation: Operation to be run
    init(operation: @escaping () async throws -> Output) where Failure == Error {
        self = Future { try await operation() }.eraseToAnyPublisher()
    }

    /// Run async operation as Publisher
    /// - Parameter operation: Operation to be run
    init(operation: @escaping () async -> Result<Output, Failure>) {
        self = Future { await operation() }.eraseToAnyPublisher()
    }

    /// Run async operation as Publisher
    /// - Parameter operation: Operation to be run
    init(operation: @escaping () async -> Output) where Failure == Never {
        self = Future { await operation() }.eraseToAnyPublisher()
    }
}
