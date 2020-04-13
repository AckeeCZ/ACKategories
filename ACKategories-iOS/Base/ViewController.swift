//
//  ViewController.swift
//  ACKategories
//
//  Created by Jan Misar on 02/04/2019.
//  Copyright © 2019 Ackee, s.r.o. All rights reserved.
//

import UIKit
import os.log

extension Base {

    /// Turn on/off logging of init/deinit of all VCs
    /// ⚠️ Has no effect when Base.memoryLoggingEnabled is true
    public static var viewControllerMemoryLoggingEnabled: Bool = true

    /// Base class for all view controllers
    open class ViewController: UIViewController {

        /// Navigation bar is shown/hidden in viewWillAppear according to this flag
        open var hasNavigationBar: Bool = true

        public init() {
            super.init(nibName: nil, bundle: nil)

            if Base.memoryLoggingEnabled && Base.viewControllerMemoryLoggingEnabled {
                if #available(iOS 10.0, *) {
                    os_log("📱 👶 %@", log: Logger.lifecycleLog(), type: .info, self)
                } else {
                    NSLog("📱 👶 \(self)")
                }
            }
        }

        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private var firstWillAppearOccurred = false

        override open func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            if !firstWillAppearOccurred {
                viewWillFirstAppear(animated)
                firstWillAppearOccurred = true
            }

            navigationController?.setNavigationBarHidden(!hasNavigationBar, animated: animated)
        }

        private var firstDidAppearOccurred = false

        override open func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            if !firstDidAppearOccurred {
                viewDidFirstAppear(animated)
                firstDidAppearOccurred = true
            }
        }

        /// Method is called when `viewWillAppear(_:)` is called for the first time
        open func viewWillFirstAppear(_ animated: Bool) {
            // to be overridden
        }

        /// Method is called when `viewDidAppear(_:)` is called for the first time
        open func viewDidFirstAppear(_ animated: Bool) {
            // to be overridden
        }

        deinit {
            if Base.memoryLoggingEnabled && Base.viewControllerMemoryLoggingEnabled {
                if #available(iOS 10.0, *) {
                    os_log("📱 ⚰️ %@", log: Logger.lifecycleLog(), type: .info, self)
                } else {
                    NSLog("📱 ⚰️ \(self)")
                }
            }
        }
    }
}
