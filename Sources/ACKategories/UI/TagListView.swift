#if canImport(UIKit) && !os(watchOS)
import UIKit

/// View to show collection of views in flow layout style
@objc(ACKTagListView)
open class TagListView: UIView {

    /// Horizontal spacing between elements in the list
    open var horizontalSpacing: CGFloat = 0

    /// Vertical spacing between elements in the list
    open var verticalSpacing: CGFloat = 0

    /// Assign views you want to show to this property
    open var tagViews: [UIView] = [] {
        didSet {
            rearrangeViews()
            layoutIfNeeded() // must be called to work properly in UITableViewCell 🧙‍♂️
        }
    }

    override public var intrinsicContentSize: CGSize {
        countedSize
    }

    /// Computed size of the list based on the given views
    private var countedSize: CGSize = .zero

    // MARK: - Initializers

    override public init(frame: CGRect) {
        super.init(frame: frame)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setNeedsLayout),
            name: UIContentSizeCategory.didChangeNotification,
            object: nil
        )
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout lifecycle

    override public func layoutSubviews() {
        super.layoutSubviews()

        rearrangeViews()
    }

    /// Computes the final size of the list based on the given `tagViews`
    private func rearrangeViews() {
        subviews.forEach { $0.removeFromSuperview() }

        // Tags are displayed in rows.
        // Current row can change dynamically during the computation of the tag's size.
        var currentRow = UIView(frame: .zero)
        addSubview(currentRow)

        tagViews.forEach { tagView in

            // Layout and get size
            tagView.layoutIfNeeded()
            tagView.frame.size = tagView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

            // Ensure the width doesn't exceed the maximum width of the list
            tagView.frame.size.width = frame.width == 0 ? tagView.frame.width : min(tagView.frame.width, frame.width)

            // If the width of the current tag plus all the previous tags
            // is greater than the width of the whole list
            // add new row to the list.
            if frame.width > 0 && currentRow.frame.width + horizontalSpacing + tagView.frame.width - frame.width > pow(10, -5) {
                currentRow = UIView(
                    frame: CGRect(
                        x: 0,
                        y: currentRow.frame.origin.y + currentRow.frame.height + verticalSpacing,
                        width: 0,
                        height: 0
                    )
                )
                addSubview(currentRow)
            }

            currentRow.addSubview(tagView)
            tagView.frame.origin.x = currentRow.frame.width

            // Add horizontal spacing if the tag is not first in the current row
            if currentRow.frame.width > 0 {
                tagView.frame.origin.x += horizontalSpacing
            }

            // Update current row's dimensions
            currentRow.frame.size.width = tagView.frame.origin.x + tagView.frame.width
            currentRow.frame.size.height = max(currentRow.frame.height, tagView.frame.height)
        }

        // Center tags within their rows
        subviews.forEach { row in
            row.subviews.forEach { tagView in

                // Update only tags that are smaller than its row
                guard tagView.frame.height < row.frame.height else { return }

                tagView.frame.origin.y = (row.frame.height - tagView.frame.height) / 2
            }
        }

        countedSize = CGSize(
            // Previous version: `width: subviews.map(\.frame.width).reduce(0, max)`,
            // We need to stretch the view automatically to the maximum possible size.
            // Tested and it looks good in the whole app.
            width: UIScreen.main.bounds.width,
            height: currentRow.frame.origin.y + currentRow.frame.height
        )

        invalidateIntrinsicContentSize()
    }
}
#endif
