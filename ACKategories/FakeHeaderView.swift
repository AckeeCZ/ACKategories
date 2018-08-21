import UIKit

/// View that can be used to make different color
/// when scrollView bounces on top
@available(iOS 9.0, *)
public final class FakeHeaderView: TableHeaderFooterView {
    
    // MARK: Initializers
    
    public init(color: UIColor, height: CGFloat = 2000) {
        super.init(frame: .zero)
        
        clipsToBounds = false
        translatesAutoresizingMaskIntoConstraints = false
        
        let subview = UIView()
        subview.backgroundColor = color
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        subview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        subview.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
