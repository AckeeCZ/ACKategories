//
//  BaseViewModel.swift
//  ProjectTemplate
//
//  Created by Jan Misar on 16.08.18.
//

import Foundation
import os.log

public extension Base {
    
    /// Turn on/off logging of init/deinit of all VMs
    /// ⚠️ Has no effect when Base.memoryLoggingEnabled is true
    static var viewModelMemoryLoggingEnabled: Bool = true
    
    /// Base class for all view models
    open class ViewModel {
        
        init() {
            if Base.memoryLoggingEnabled && Base.viewModelMemoryLoggingEnabled {
                if #available(iOSApplicationExtension 10.0, *) {
                    os_log("🧠 👶 %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
                } else {
                    NSLog("🧠 👶 \(self)")
                }
            }
        }
        
        deinit {
            if Base.memoryLoggingEnabled && Base.viewModelMemoryLoggingEnabled {
                if #available(iOSApplicationExtension 10.0, *) {
                    os_log("🧠 ⚰️ %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
                } else {
                    NSLog("🧠 ⚰️ \(self)")
                }
            }
        }
    }
    
    /// Empty class for Base.ViewControllerNoVM
    class NoViewModel {}
}