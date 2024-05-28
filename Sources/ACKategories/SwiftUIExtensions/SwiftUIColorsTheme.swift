#if canImport(UIKit)
import SwiftUI
import UIKit

/// Using this namespace you can define your colors in ``Theme`` extension of `UIColor`
/// and they will automatically appear in `Color.theme` namespace.
///
/// Make sure your extensions are not defined as static, only instance variables with type `UIColor` will be bridged.
///
/// ## Example
///
/// ```swift
/// extension Theme<UIColor> {
///     var primary: UIColor { .red }
/// }
/// ```
///
/// Then you can use `Color.theme.primary` in SwiftUI
@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
@dynamicMemberLookup
public struct SwiftUIColorsTheme {
    public subscript(dynamicMember keyPath: KeyPath<Theme<UIColor>, UIColor>) -> SwiftUI.Color {
        let uiColor = Theme<UIColor>()[keyPath: keyPath]
        return .init(uiColor)
    }
}

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
public extension Color {
    /// Namespace for bridged ``Theme`` colors from `Theme<UIColor>` extension, see ``SwiftUIColorsTheme``.
    static let theme = SwiftUIColorsTheme()
}
#endif
