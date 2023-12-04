#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UIDevice {
    /// Return **true** if device is iPad
    public var isPad: Bool {
        return userInterfaceIdiom == .pad
    }

    /// Return **true** if device is Apple TV
    public var isTV: Bool {
        userInterfaceIdiom == .tv
    }

    /// Return **true** if device is Mac (Catalyst)
    @available(iOS 14.0, tvOS 14.0, *)
    public var isMac: Bool {
        userInterfaceIdiom == .mac
    }

    /// Returns device model name e.g. "iPhone11,6" for XS Max
    public var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}
#endif
