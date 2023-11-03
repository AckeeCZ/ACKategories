import Combine

@available(macOS 10.15, iOS 13.0, *)
public extension Future where Failure == Error {
    convenience init(operation: @escaping () async throws -> Output) {
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
}

@available(macOS 10.15, iOS 13.0, *)
public extension AnyPublisher where Failure == Error {
    init(operation: @escaping () async throws -> Output) {
        self = Future { try await operation() }.eraseToAnyPublisher()
    }
}

