//
//  CollectionViewDataSource.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 29/12/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public protocol CollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
}

public extension CollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "", forIndexPath: indexPath)
    }
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    }
}

public extension CollectionViewDataSource where Self: Sectionable {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems(inSection: section)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
}

public extension CollectionViewDataSource where Self: Sectionable, Self.ItemType == Self.Section.Data.Element, Self: CellProviding, Self.CellType == UICollectionViewCell, Self.ViewType == UICollectionView {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = reuseIdentifier(forIndexPath: indexPath)
        guard let itemAtIndexPath = item(atIndexPath: indexPath) else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
        configure(cell: cell, forItem: itemAtIndexPath as ItemType, inView: collectionView)
        return cell
    }
}
