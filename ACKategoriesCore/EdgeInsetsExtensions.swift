import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
public extension SwiftUI.EdgeInsets {
    /// Initialize edge insets with the same padding for all edges
    init(_ size: CGFloat) {
        self.init(
            top: size,
            leading: size,
            bottom: size,
            trailing: size
        )
    }
}
