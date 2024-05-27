#if !os(macOS)
import os.log
import SwiftUI

@available(iOS 13.0, tvOS 13.0, *)
open class ACKHostingController<RootView: View>: UIHostingController<RootView> {
    /// Navigation bar is shown/hidden in viewWillAppear according to this flag
    public var hasNavigationBar = true

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        get { _preferredStatusBarStyle }
        set {
            _preferredStatusBarStyle = newValue
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    private var _preferredStatusBarStyle: UIStatusBarStyle = .default

    // MARK: - Initializers

    public override init(rootView: RootView) {
        super.init(rootView: rootView)

        navigationItem.backButtonTitle = ""

        if Base.memoryLoggingEnabled && Base.viewControllerMemoryLoggingEnabled {
            os_log("📱 👶 %@", log: Logger.lifecycleLog(), type: .info, self)
        }
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        if Base.memoryLoggingEnabled && Base.viewControllerMemoryLoggingEnabled {
            os_log("📱 ⚰️ %@", log: Logger.lifecycleLog(), type: .info, self)
        }
    }

    // MARK: - View life cycle

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(!hasNavigationBar, animated: animated)
    }
}
#endif
