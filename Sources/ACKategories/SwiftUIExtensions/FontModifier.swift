#if canImport(UIKit)
import SwiftUI
import UIKit

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
public extension View {
    /// Sets font and line height for text in this view.
    ///
    /// - Parameters:
    ///    - font: The font to use in this view.
    ///    - lineHeight: The line height to use in this view.
    ///    - textStyle: The text style for relative font scaling. If `nil`is specified then dynamic type is turned off.
    @ViewBuilder func font(
        _ font: UIFont,
        lineHeight: Double?,
        textStyle: Font.TextStyle?
    ) -> some View {
        // Do not scale font based on dynamic type when nil `relativeTo` specified
        let customFont = textStyle
            .map { Font.custom(font.fontName, size: font.pointSize, relativeTo: $0) } ?? Font(font)

        if let lineHeight {
            self.font(customFont)
                .lineSpacing(lineHeight - font.lineHeight)
                .padding(.vertical, (lineHeight - font.lineHeight) / 2)
        } else {
            self.font(customFont)
        }
    }
}
#endif
