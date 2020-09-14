import UIKit

/// This view will autolayout its height, even when used as a tableHeaderView or tableFooterView.
@available(*, deprecated, message: "Use SelfSizingTableHeaderFooterView instead. TableHeaderFooterView inherits from UIView and not UITableViewHeaderFooterView, its readableContentGuide behaves differently from UITableViewCells.")
open class TableHeaderFooterView: UIView {
    fileprivate var tableView: UITableView? {
        return superview as? UITableView
    }

    fileprivate var status: Status {
        return self == tableView?.tableHeaderView ? .header :
            self == tableView?.tableFooterView ? .footer :
            .none
    }

    fileprivate enum Status {
        case header // is set as tableHeaderView
        case footer // is set as tableFooterView
        case none // is used as normal view elsewhere
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        if status == .none {
            return
        }

        var frame = self.frame
        let size = systemLayoutSizeFitting(
            CGSize(width: frame.width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: UILayoutPriority(rawValue: 1000),
            verticalFittingPriority: UILayoutPriority(rawValue: 500)
        )

        frame.size.height = size.height
        self.frame = frame

        switch status {
        case .header: tableView?.tableHeaderView = self
        case .footer: tableView?.tableFooterView = self
        case .none: return
        }
    }
}
