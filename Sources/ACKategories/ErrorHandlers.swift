//
//  ErrorHandlers.swift
//  ACKategories-iOS
//
//  Created by Lukáš Hromadník on 07.12.2020.
//

import Foundation

/// Set of handlers for some undefined behaviors in the framework
public enum ErrorHandlers {

    /// Called when `rootViewController` of the respective flow coordinator
    /// is deallocated before the actual stop method logic is called
    public static var rootViewControllerDeallocatedBeforeStop: (() -> Void)?
}
