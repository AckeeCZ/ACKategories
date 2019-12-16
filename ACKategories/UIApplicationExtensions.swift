//
//  UIApplicationExtensions.swift
//  ACKategories
//
//  Created by Igor Rosocha on 12/16/19.
//  Copyright © 2019 Ackee, s.r.o. All rights reserved.
//

import UIKit

public extension UIApplication {
    /// Completely clear launch screen cache
    func clearLaunchScreenCache() {
        do {
            try FileManager.default.removeItem(atPath: NSHomeDirectory() + "/Library/SplashBoard")
        } catch {
            print("Failed to delete launch screen cache: \(error)")
        }
    }
}
