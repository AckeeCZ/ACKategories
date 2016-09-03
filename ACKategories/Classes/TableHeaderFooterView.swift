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
        let height = systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        var frame = self.frame
        frame.size.height = height
        self.frame = frame
    }
}