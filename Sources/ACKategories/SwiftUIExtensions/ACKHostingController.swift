import SwiftUI

@available(iOS 13.0, *)
open class ACKHostingController<RootView: View>: Base.ViewController {
    public let hostingVC: UIHostingController<RootView>
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        get { _preferredStatusBarStyle }
        set {
            _preferredStatusBarStyle = newValue
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    private var _preferredStatusBarStyle: UIStatusBarStyle = .default

    // MARK: - Initializers

    public init(rootView: RootView) {
        hostingVC = .init(rootView: rootView)
        super.init()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View life cycle

    open override func loadView() {
        super.loadView()

        view.backgroundColor = .systemBackground

        hostingVC.willMove(toParent: self)
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        hostingVC.didMove(toParent: self)
    }
}
