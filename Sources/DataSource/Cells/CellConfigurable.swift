import Foundation

public protocol CellConfigurable: class {
    associatedtype Model: CellConvertible
    func configure(with model: Model)
}
