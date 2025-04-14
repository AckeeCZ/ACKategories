import SwiftUI

@available(iOS 13, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    public func frame(size: CGSize) -> some View {
        assert(size.width.isFinite)
        assert(size.width >= 0)
        assert(size.height.isFinite)
        assert(size.height >= 0)
        return frame(width: size.width, height: size.height)
    }

    public func frame(size: CGSize, alignment: Alignment) -> some View {
        frame(width: size.width, height: size.height, alignment: alignment)
    }
}
