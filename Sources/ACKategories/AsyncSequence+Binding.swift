import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension AsyncSequence {
    @discardableResult
    func bind(_ newElement: @escaping (Element) -> ()) -> Task<(), Error> {
        .init { [iterator = makeAsyncIterator()] in
            var iterator = iterator

            while let element = try await iterator.next() {
                newElement(element)
            }
        }
    }
}
