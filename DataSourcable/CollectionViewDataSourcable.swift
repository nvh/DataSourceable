//
//  CollectionViewDataSourcable.swift
//  DataSourcable
//
//  Created by Niels van Hoorn on 13/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public protocol CollectionViewCellProviding {
    typealias ItemType
    func reuseIdentifier(forIndexPath indexPath: NSIndexPath) -> String
    func configure(cell cell: UICollectionViewCell, forItem item: ItemType, inCollectionView collectionView: UICollectionView) -> UICollectionViewCell
}

public protocol CollectionViewDataSourcable: Sectionable, CollectionViewCellProviding {}

public extension CollectionViewDataSourcable where ItemType == Section.Data._Element, Section.Data.Index == Int {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems(inSection: section)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = reuseIdentifier(forIndexPath: indexPath)
        guard let itemAtIndexPath = item(atIndexPath: indexPath) else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
        configure(cell: cell, forItem: itemAtIndexPath as ItemType, inCollectionView: collectionView)
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
}

//This could just be a protocol extension if UICollectionViewDatasSource wouldn't enforce @objc
public class CollectionViewDataSourceProxy<D: CollectionViewDataSourcable where D.ItemType == D.Section.Data._Element, D.Section.Data.Index == Int>: NSObject, UICollectionViewDataSource {
    public var dataSource: D
    
    public init(dataSource: D) {
        self.dataSource = dataSource
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return dataSource.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSectionsInCollectionView(collectionView)
    }
}
