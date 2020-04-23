import UIKit

open class DataSource: NSObject {

    // MARK: - Properties

    public var sections: [Section] = [] {
        didSet {
            sectionsDidUpdate(sections)
        }
    }

    public weak var tableViewDelegate: TableViewDataSourceDelegate?

    var registeredCellModelIdentifiers = Set<String>()
    var registeredHeaderFooterModelIdentifiers = Set<String>()
    var canCallScrollToBottom: Bool = true

    // MARK: - Initialization

    public override init() {
    }

    public init(sections: [Section]) {
        self.sections = sections
    }

    // MARK: - Utilities

    open func sectionsDidUpdate(_ sections: [Section]) {
        canCallScrollToBottom = true
    }
}

// MARK: - UIScrollViewDelegate

extension DataSource {
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > (contentHeight - scrollView.frame.height), canCallScrollToBottom {
            tableViewDelegate?.tableViewWillScrollToBottom()
            canCallScrollToBottom = false
        }
    }
}
