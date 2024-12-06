import SwiftUI

@available(iOS 13.0, *)
public extension View {

    @available(iOSApplicationExtension, unavailable)
    func endEditingOnTap(
        _ action: (() -> Void)? = nil
    ) -> some View {
        onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil
            )
            action?()
        }
    }
}
