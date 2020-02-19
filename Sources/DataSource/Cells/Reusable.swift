import UIKit

public protocol Reusable {
    var reuseIdentifier: String { get }
    var bundle: Bundle { get }
    var nib: UINib? { get }
    var cellClass: AnyClass { get }
}

public extension Reusable {
    var reuseIdentifier: String {
        String(describing: cellClass)
    }

    var bundle: Bundle {
        Bundle(for: cellClass)
    }

    var nib: UINib? {
        UINib(nibName: reuseIdentifier, bundle: bundle)
    }
}

public extension Reusable where Self: UIView {
    var cellClass: AnyClass {
        type(of: self)
    }
}
