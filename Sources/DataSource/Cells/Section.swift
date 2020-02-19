import Foundation

// TODO: - Hashable (so we can do animated changes).
public struct Section {

    // MARK: - Properties

    public var cells: [CellModel]
    public var header: HeaderFooterViewModel?
    public var footer: HeaderFooterViewModel?

    // MARK: - Initialization

    public init(cells: [CellModel] = [], header: HeaderFooterViewModel? = nil, footer: HeaderFooterViewModel? = nil) {
        self.cells = cells
        self.header = header
        self.footer = footer
    }

    public init(cell: CellModel, header: HeaderFooterViewModel? = nil, footer: HeaderFooterViewModel? = nil) {
        self.cells = [cell]
        self.header = header
        self.footer = footer
    }
}

// MARK: - Utilities

extension Array where Element == Section {
    var noCells: Bool {
        flatMap { $0.cells }.isEmpty
    }
}
