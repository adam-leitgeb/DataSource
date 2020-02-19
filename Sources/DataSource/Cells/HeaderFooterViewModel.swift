//
//  HeaderFooterViewModel.swift
//  SlspB24
//
//  Created by Adam Leitgeb on 13/05/2019.
//  Copyright © 2019 BSC. All rights reserved.
//

import UIKit

public protocol HeaderFooterViewModel: Reusable {
    var height: CGFloat { get }

    func configure(_ cell: AnyObject)
}
