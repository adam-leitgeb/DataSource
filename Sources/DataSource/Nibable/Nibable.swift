//
//  Nibable.swift
//  SlspB24
//
//  Created by Adam Leitgeb on 13/05/2019.
//  Copyright © 2019 BSC. All rights reserved.
//

import UIKit

public protocol Nibable {
    static var nib: UINib { get }
}

public extension Nibable where Self: UIView {
    static var nib: UINib {
        UINib(nibName: Self.nibName, bundle: nil)
    }

    init(owner: AnyObject? = nil) {
        let views = Self.nib.instantiate(withOwner: owner, options: [:])
        for view in views {
            if let view = view as? Self {
                self = view
                return
            }
        }
        fatalError("Nib for class \(Self.nibName) cound not be loaded!")
    }
}
