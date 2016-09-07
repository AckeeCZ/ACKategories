/// This view will autolayout its height, even when used as a tableHeaderView or tableFooterView.

class TableHeaderFooterView: UIView {
    private var tableView: UITableView? {
        return superview as? UITableView
    }
    private var status: Status {
        return self == tableView?.tableHeaderView ? .Header :
            self == tableView?.tableFooterView ? .Footer :
            .None
    }
    private enum Status {
        case Header // is set as tableHeaderView
        case Footer // is set as tableFooterView
        case None // is used as normal view elsewhere
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        switch status {
        case .Header: defer { tableView?.tableHeaderView = self }
        case .Footer: defer { tableView?.tableFooterView = self }
        case .None: return
        }

        var frame = self.frame
        let height = systemLayoutSizeFittingSize(CGSize(width: frame.width, height: UILayoutFittingCompressedSize.height), withHorizontalFittingPriority: 1000, verticalFittingPriority: 500).height

        frame.size.height = height
        self.frame = frame
    }
}
