//
//  DataSource+TableView.swift
//  FYMO
//
//  Created by Adam Leitgeb on 31/07/2019.
//  Copyright © 2019 Adam Leitgeb. All rights reserved.
//

import UIKit

public protocol TableViewDataSourceDelegate: class {
    func tableViewWillScrollToBottom()
}

// MARK: - UITableViewDataSource

extension DataSource: UITableViewDataSource {

    // MARK: - Headers

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerModel = sections[section].header else {
            return nil
        }
        registerHeaderFooterIfNeeded(with: headerModel, in: tableView)

        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerModel.reuseIdentifier)
        headerView.flatMap { headerModel.configure($0) }

        return headerView
    }

    // MARK: - Footer

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerModel = sections[section].footer else {
            return nil
        }
        registerHeaderFooterIfNeeded(with: footerModel, in: tableView)

        let footerView: UIView? = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerModel.reuseIdentifier)
        footerView.flatMap { footerModel.configure($0) }

        return footerView
    }

    // MARK: - Cells

    public func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].cells.count
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = sections[indexPath.section].cells[indexPath.row]
        registerCellIfNeeded(with: cellModel, in: tableView)

        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.reuseIdentifier, for: indexPath)
        cellModel.configure(cell)

        return cell
    }

    // MARK: - Utilities

    public func registerCellIfNeeded(with cellModel: CellModel, in tableView: UITableView) {
        guard !registeredCellModelIdentifiers.contains(cellModel.reuseIdentifier) else {
            return
        }

        if let nib = cellModel.nib {
            tableView.register(nib, forCellReuseIdentifier: cellModel.reuseIdentifier)
        } else {
            tableView.register(cellModel.cellClass, forCellReuseIdentifier: cellModel.reuseIdentifier)
        }
        registeredCellModelIdentifiers.insert(cellModel.reuseIdentifier)
    }

    public func registerHeaderFooterIfNeeded(with headerFooterModel: HeaderFooterViewModel, in tableView: UITableView) {
        guard !registeredCellModelIdentifiers.contains(headerFooterModel.reuseIdentifier) else {
            return
        }

        if let nib = headerFooterModel.nib {
            tableView.register(nib, forHeaderFooterViewReuseIdentifier: headerFooterModel.reuseIdentifier)
        } else {
            tableView.register(headerFooterModel.cellClass, forHeaderFooterViewReuseIdentifier: headerFooterModel.reuseIdentifier)
        }
        registeredHeaderFooterModelIdentifiers.insert(headerFooterModel.reuseIdentifier)
    }
}

// MARK: - UITableViewDelegate

extension DataSource: UITableViewDelegate {

    // MARK: - Headers

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let headerModel = sections[section].header else {
            return 0.0
        }
        return headerModel.height
    }

    // MARK: - Footers

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let footerModel = sections[section].footer else {
            return 0.0
        }
        return footerModel.height
    }

    // MARK: - Cells

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cellSelectable = sections[indexPath.section].cells[indexPath.row] as? CellModelSelectable {
            cellSelectable.selectionHandler?()

            if cellSelectable.deselectAutomatically {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }

    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let cellModel = sections[indexPath.section].cells[indexPath.row]
        return cellModel.isHighlighting
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellModel = sections[indexPath.section].cells[indexPath.row]
        return cellModel.height
    }

    // Actions

    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        sections[indexPath.section].cells[indexPath.row] as? CellModelActionable != nil
    }

    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard let cellModel =  sections[indexPath.section].cells[indexPath.row] as? CellModelActionable else {
            return nil
        }

        return cellModel.rowActions.map { action in
            let actionForRow = UITableViewRowAction(style: action.style, title: action.title) { _, _ in
                action.handler()
            }
            actionForRow.backgroundColor = action.backgroundColor
            return actionForRow
        }
    }
}

