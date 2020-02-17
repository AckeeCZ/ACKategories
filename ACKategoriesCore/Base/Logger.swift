//
//  Logger.swift
//  ProjectTemplate
//
//  Created by Marek Fořt on 1/10/19.
//

import Foundation
import os.log

/// Contains pre-defined OSLog categories
public struct LoggerCategory {
    /// Generic app logging category
    public static var app: String { return "App" }
    /// Networking logging category
    public static var networking: String { return "Networking" }
    /// Lifecycle logging category
    public static var lifecycle: String { return "Lifecycle" }
}

/// Wrapper class for os_log function
@available(iOS 10.0, macOS 10.12, *)
public struct Logger {
    /// Create OSLog with subsystem and category
    public static func osLog(subsystem: String = Bundle.main.bundleIdentifier ?? "-", category: String) -> OSLog {
        return OSLog(subsystem: subsystem, category: category)
    }

    /// Create app log
    public static func appLog() -> OSLog {
        return OSLog(subsystem: Bundle.main.bundleIdentifier ?? "-", category: LoggerCategory.app)
    }

    /// Create networking log
    public static func networkingLog() -> OSLog {
        return OSLog(subsystem: Bundle.main.bundleIdentifier ?? "-", category: LoggerCategory.networking)
    }

    /// Create lifecycle log
    public static func lifecycleLog() -> OSLog {
        return OSLog(subsystem: Bundle.main.bundleIdentifier ?? "-", category: LoggerCategory.lifecycle)
    }
}
