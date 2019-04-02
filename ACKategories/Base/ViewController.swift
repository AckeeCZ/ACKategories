//
//  ViewController.swift
//  ACKategories
//
//  Created by Jan Misar on 02/04/2019.
//  Copyright © 2019 Ackee, s.r.o. All rights reserved.
//

import UIKit
import os.log

public extension Base {
    
    /// Turn on/off logging of init/deinit of all VCs
    /// ⚠️ Has no effect when Base.memoryLoggingEnabled is true
    static var viewControllerMemoryLoggingEnabled: Bool = true
    
    /// Base class for all view controllers
    open class ViewController<ViewModelType>: UIViewController {
        
        /// Navigation bar is shown/hidden in viewWillAppear according to this flag
        var hasNavigationBar: Bool = true
        
        /// Corresponding viewModel
        public let viewModel: ViewModelType
        
        public init(viewModel: ViewModelType) {
            self.viewModel = viewModel
            
            super.init(nibName: nil, bundle: nil)
            
            if Base.memoryLoggingEnabled && Base.viewControllerMemoryLoggingEnabled {
                os_log("📱 👶 %@", log: Logger.lifecycleLog(), type: .info, self)
            }
        }
        
        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private var firstWillAppearOccured = false
        
        override open func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            if !firstWillAppearOccured {
                viewWillFirstAppear(animated)
                firstWillAppearOccured = true
            }
            
            navigationController?.setNavigationBarHidden(!hasNavigationBar, animated: animated)
        }
        
        private var firstDidAppearOccured = false
        
        override open func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            if !firstDidAppearOccured {
                viewDidFirstAppear(animated)
                firstDidAppearOccured = true
            }
        }
        
        /// Method is called when `viewWillAppear(_:)` is called for the first time
        open func viewWillFirstAppear(_ animated: Bool) {
            // to be overriden
        }
        
        /// Method is called when `viewDidAppear(_:)` is called for the first time
        open func viewDidFirstAppear(_ animated: Bool) {
            // to be overriden
        }
        
        deinit {
            if Base.memoryLoggingEnabled && Base.viewControllerMemoryLoggingEnabled {
                os_log("📱 ⚰️ %@", log: Logger.lifecycleLog(), type: .info, self)
            }
        }
    }
    
}
