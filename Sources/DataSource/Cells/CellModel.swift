import Foundation
import UIKit

public protocol CellModel: Reusable {
    var height: CGFloat { get }
    var isHighlighting: Bool { get }

    func configure(_ cell: AnyObject)
}

public extension CellModel {
    var height: CGFloat {
        UITableView.automaticDimension
    }

    var isHighlighting: Bool {
        self is CellModelSelectable
    }
}
