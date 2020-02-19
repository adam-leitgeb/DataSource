//
//  DataSource+CollectionView.swift
//  DataSourceSampleProject
//
//  Created by Adam Leitgeb on 13/07/2019.
//  Copyright © 2019 Adam Leitgeb. All rights reserved.
//

import UIKit

// MARK: - UICollectionViewDataSource

extension DataSource: UICollectionViewDataSource {

    // MARK: - Headers

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerModel = sections[indexPath.section].header else {
            return UICollectionReusableView()
        }
        registerHeaderFooterIfNeeded(headerModel, of: kind, in: collectionView)

        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerModel.reuseIdentifier, for: indexPath)
        headerModel.configure(headerView)

        return headerView
    }

    // MARK: - Cells

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].cells.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellModel = sections[indexPath.section].cells[indexPath.row]
        registerCellIfNeeded(with: cellModel, in: collectionView)

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellModel.reuseIdentifier, for: indexPath)
        cellModel.configure(cell)

        return cell
    }

    // MARK: - Utilities

    public func registerCellIfNeeded(with cellModel: CellModel, in collectionView: UICollectionView) {
        guard !registeredCellModelIdentifiers.contains(cellModel.reuseIdentifier) else {
            return
        }

        if let nib = cellModel.nib {
            collectionView.register(nib, forCellWithReuseIdentifier: cellModel.reuseIdentifier)
        } else {
            collectionView.register(cellModel.cellClass, forCellWithReuseIdentifier: cellModel.reuseIdentifier)
        }
        registeredCellModelIdentifiers.insert(cellModel.reuseIdentifier)
    }

    private func registerHeaderFooterIfNeeded(_ headerFooterModel: HeaderFooterViewModel, of kind: String, in collectionView: UICollectionView) {
        guard !registeredCellModelIdentifiers.contains(headerFooterModel.reuseIdentifier) else {
            return
        }

        if let nib = headerFooterModel.nib {
            collectionView.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: headerFooterModel.reuseIdentifier)
        } else {
            collectionView.register(headerFooterModel.cellClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: headerFooterModel.reuseIdentifier)
        }
        registeredHeaderFooterModelIdentifiers.insert(headerFooterModel.reuseIdentifier)
    }
}

extension DataSource: UICollectionViewDelegate {

    // MARK: - Cells

    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        let cellModel = sections[indexPath.section].cells[indexPath.row]
        return cellModel.isHighlighting
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cellSelectable = sections[indexPath.section].cells[indexPath.row] as? CellModelSelectable {
            cellSelectable.selectionHandler?()
        }
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
