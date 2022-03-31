import Combine

@available(macOS 10.15, iOS 13.0, *)
extension Publisher where Failure == Never {
    /// Weakifies `Root` object and assigns `Output` to `keyPath` on `Root`.
    public func weakAssign<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Output>, on object: Root) -> AnyCancellable {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}

@available(macOS 10.15, iOS 13.0, *)
extension Publishers {
    /// A publisher created by applying the zip function to an arbitrary number of upstream publishers.
    public struct ZipMany<Upstream>: Publisher where Upstream: Publisher {
        /// The kind of values published by this publisher.
        ///
        /// This publisher uses an array of its upstream publishers' common output type.
        public typealias Output = [Upstream.Output]

        /// The kind of errors this publisher might publish.
        ///
        /// This publisher uses its upstream publishers' common failure type.
        public typealias Failure = Upstream.Failure

        /// The array of upstream publishers that this publisher zips together.
        private let publishers: [Upstream]

        /// Creates a publisher created by applying the zip function to an array of upstream publishers.
        /// - Parameter upstream: An array containing zero or more publishers to zip with this publisher.
        public init(_ upstreams: [Upstream]) {
            self.publishers = upstreams
        }

        /// Creates a publisher created by applying the zip function to an arbitrary number of upstream publishers.
        /// - Parameter upstream: A variadic parameter containing zero or more publishers to zip with this publisher.
        public init(_ upstreams: Upstream...) {
            self.publishers = upstreams
        }

        public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let initial: AnyPublisher<Output, Failure>? = nil
            let emptyPublisher = Just(Output()).setFailureType(to: Failure.self).eraseToAnyPublisher()

            let zipped = publishers.reduce(into: initial) { partialResult, upstream in
                if let res = partialResult {
                    partialResult = res.zip(upstream) { elements, element in
                        elements + [element]
                    }.eraseToAnyPublisher()
                } else {
                    partialResult = upstream.map { [$0] }.eraseToAnyPublisher()
                }
            } ?? emptyPublisher

            zipped.subscribe(subscriber)
        }
    }
}
