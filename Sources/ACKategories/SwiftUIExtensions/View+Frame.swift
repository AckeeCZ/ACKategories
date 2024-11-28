import SwiftUI

@available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13.0, *)
public extension View {
    func readSize(
        onChange: @escaping (CGSize) -> Void
    ) -> some View {
        readFrame(in: .local) { onChange($0.size) }
    }

    func readFrame(
        in coordinateSpace: CoordinateSpace,
        onChange: @escaping (CGRect) -> Void
    ) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: FramePreferenceKey.self, value: geometryProxy.frame(in: coordinateSpace))
            }
        )
        .onPreferenceChange(FramePreferenceKey.self, perform: onChange)
    }
}

private struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) { }
}

@available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13.0, *)
#Preview {
    Text("Hello, World!")
        .readSize {
            print("Size:", $0)
        }
        .readFrame(in: .local) {
            print("Local frame:", $0)
        }
        .readFrame(in: .global) {
            print("Global frame:", $0)
        }
}
