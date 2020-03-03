//
//  CellModelSelectable.swift
//  DataSourceSampleProject
//
//  Created by Adam Leitgeb on 26/04/2019.
//  Copyright © 2019 Adam Leitgeb. All rights reserved.
//

import Foundation

public protocol CellModelSelectable {
    var selectionHandler: (() -> Void)? { get }
    var deselectAutomatically: Bool { get }
}

public extension CellModelSelectable {
    var deselectAutomatically: Bool {
        true
    }
}
