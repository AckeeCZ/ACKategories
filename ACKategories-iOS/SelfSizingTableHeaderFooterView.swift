//
//  SelfSizingTableHeaderFooterView.swift
//  ACKategories-iOS
//
//  Created by Karel Leinhäupl on 06.09.2020.
//

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
        super.layoutSubviews()

        guard status != .none else { return }
        let frameSize = fittingSize(for: self)
        let contentViewSize = fittingSize(for: contentView)
        frame = CGRect(
            origin: frame.origin,
            size: frameSize
        )
        contentView.frame = CGRect(
            origin: contentView.frame.origin,
            size: contentViewSize
        )

        switch status {
        case .header: tableView?.tableHeaderView = self
        case .footer: tableView?.tableFooterView = self
        case .none: return
        }
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
