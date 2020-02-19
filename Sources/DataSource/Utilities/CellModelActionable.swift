//
//  CellModelActionable.swift
//  DataSourceSampleProject
//
//  Created by Adam Leitgeb on 09/05/2019.
//  Copyright © 2019 Adam Leitgeb. All rights reserved.
//

import UIKit

protocol CellModelActionable {
    var rowActions: [CellModelRowAction] { get }
}

struct CellModelRowAction {
    let title: String
    let style: UITableViewRowAction.Style
    let backgroundColor: UIColor
    let handler: () -> Void
}
