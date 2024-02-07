import Foundation
import UserNotifications

@available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13.0, *)
public protocol PushManaging {
    var actions: PushManagingActions { get }
    
    var notificationSettings: AsyncStream<UNNotificationSettings> { get }
    var currentNotificationSettings: UNNotificationSettings? { get }
}

@available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13.0, *)
public protocol PushManagingActions {
    func start()
    func requestPermission(options: UNAuthorizationOptions) async
    
    func addNotificationReceivedHandler(_ handler: @escaping (UNNotification) async -> ()) -> String
    func removeNotificationReceivedHandler(id: String)

    #if !os(tvOS)
    func addNotificationOpenedHandler(_ handler: @escaping (UNNotificationResponse) async -> ()) -> String
    func removeNotificationOpenedHandler(id: String)
    #endif
}

@available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13.0, *)
public extension PushManaging where Self: PushManagingActions {
    var actions: PushManagingActions { self }
}

@available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13.0, *)
public final class PushManager: NSObject, PushManaging, PushManagingActions {
    public private(set) lazy var notificationSettings = AsyncStream<UNNotificationSettings> { continuation in
        notificationSettingsContinuation = continuation
        
        if let currentNotificationSettings {
            continuation.yield(currentNotificationSettings)
        }
    }
    public private(set) var currentNotificationSettings: UNNotificationSettings?
    
    public lazy var presentationOptions: (UNNotification) async -> UNNotificationPresentationOptions = { [weak self] notification in
        guard let self else { return [] }
        return await notificationCenter.notificationSettings().allowedPresentationOptions
    }
    
    public var openSettings: (UNNotification?) -> () = { _ in }
    
    private let notificationCenter: UNUserNotificationCenter
    private var notificationSettingsContinuation: AsyncStream<UNNotificationSettings>.Continuation?

    private var notificationReceivedHandlers = [String: (UNNotification) async -> ()]()

    #if !os(tvOS)
    private var notificationOpenedHandlers = [String: (UNNotificationResponse) async -> ()]()
    #endif

    public init(
        notificationCenter: UNUserNotificationCenter = .current()
    ) {
        self.notificationCenter = notificationCenter
        super.init()
    }
    
    deinit {
        notificationSettingsContinuation?.finish()
    }
    
    public func start() {
        notificationCenter.delegate = self
    }
    
    public func requestPermission(options: UNAuthorizationOptions) async {
        guard let granted = try? await notificationCenter.requestAuthorization(options: options),
              granted
        else { return }
        
        let settings = await notificationCenter.notificationSettings()
        currentNotificationSettings = settings
        notificationSettingsContinuation?.yield(settings)
    }
    
    public func addNotificationReceivedHandler(
        _ handler: @escaping (UNNotification) async -> ()
    ) -> String {
        let id = UUID().uuidString
        notificationReceivedHandlers[id] = handler
        return id
    }
    
    public func removeNotificationReceivedHandler(id: String) {
        notificationReceivedHandlers[id] = nil
    }
    
    #if !os(tvOS)
    public func addNotificationOpenedHandler(
        _ handler: @escaping (UNNotificationResponse) async -> ()
    ) -> String {
        let id = UUID().uuidString
        notificationOpenedHandlers[id] = handler
        return id
    }

    public func removeNotificationOpenedHandler(id: String) {
        notificationOpenedHandlers[id] = nil
    }
    #endif
}

@available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13.0, *)
extension PushManager: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        for handler in notificationReceivedHandlers.values {
            await handler(notification)
        }
        
        return await presentationOptions(notification)
    }

    #if !os(tvOS)
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse
    ) async {
        for handler in notificationOpenedHandlers.values {
            await handler(response)
        }
    }
    #endif

    #if !os(watchOS) && !os(tvOS)
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        openSettingsFor notification: UNNotification?
    ) {
        openSettings(notification)
    }
    #endif
}
