#if canImport(UIKit) && !os(watchOS)
import UIKit

/// This view will autolayout its height, even when used as a tableHeaderView or tableFooterView.
open class SelfSizingTableHeaderFooterView: UITableViewHeaderFooterView {

    private enum Status {
        /// View is set as tableHeaderView
        case header
        /// View is set as tableFooterView
        case footer
        /// View is set as normal view elsewhere
        case none
    }

    // MARK: - Fileprivate properties

    private var tableView: UITableView? {
        return superview as? UITableView
    }

    private var status: Status {
        return self == tableView?.tableHeaderView ? .header :
            self == tableView?.tableFooterView ? .footer :
            .none
    }

    override open func layoutSubviews() {
        guard status != .none else {
            super.layoutSubviews()
            return
        }

        let size = fittingSize(for: self)
        if frame.size.height != size.height {
            frame.size.height = size.height

            switch status {
            case .header: tableView?.tableHeaderView = self
            case .footer: tableView?.tableFooterView = self
            case .none: return
            }
        }

        super.layoutSubviews()
    }

    // MARK: - Helpers

    private func fittingSize(for view: UIView) -> CGSize {
        let targetSize = CGSize(
            width: view.frame.width,
            height: UIView.layoutFittingCompressedSize.height
        )

        return systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        )
    }
}
#endif
