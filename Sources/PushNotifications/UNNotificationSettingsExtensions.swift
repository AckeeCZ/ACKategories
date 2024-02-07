import UserNotifications

@available(iOS 13.0, macOS 10.15, *)
public extension UNNotificationSettings {
    var allowedPresentationOptions: UNNotificationPresentationOptions {
        var options = [(UNNotificationSetting, UNNotificationPresentationOptions)]()

        #if !os(tvOS)
        options.append((soundSetting, UNNotificationPresentationOptions.sound))
        options.append((alertSetting, .alert))
        #endif

        #if !os(watchOS)
        options.append((badgeSetting, .badge))
        #endif

        return .init(options.compactMap { setting, option in
            if setting == .enabled { return option }
            return nil
        })
    }
}
