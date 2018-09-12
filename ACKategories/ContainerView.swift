import UIKit


@available(iOSApplicationExtension 9.0, *)
public final class ContainerView<ContainedView: UIView>: UIView {
    public private(set) weak var containedView: ContainedView!
    
    // MARK: Initializers
    
    public init(view: ContainedView) {
        super.init(frame: .zero)
        
        addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        containedView = view
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
