import Foundation
import UIKit

public protocol CellConvertible: Reusable {
    associatedtype Cell: CellConfigurable

    var height: CGFloat { get }
}

public extension CellConvertible {
    var cellClass: AnyClass {
        Cell.self
    }
}

public extension CellConvertible where Self == Cell.Model {
    func configure(_ cell: AnyObject) {
        guard let cell = cell as? Cell else {
            return assertionFailure("🧨 Cell with reuse identifier \(reuseIdentifier) is not registered!")
        }
        cell.configure(with: self)
    }
}
