//
//  CollectionViewDataSourceableSpec.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 21/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

import UIKit
import DataSourceable
import Quick
import Nimble

struct SimpleCollectionViewDataSource: CollectionViewDataSourceable {
    typealias ItemType = UIColor
    var sections: [[UIColor]]? = [[UIColor.redColor(),UIColor.blueColor(),UIColor.greenColor()],[UIColor.blackColor(),UIColor.whiteColor()],[UIColor.yellowColor(),UIColor.purpleColor(),UIColor.orangeColor(),UIColor.magentaColor()]]

    func reuseIdentifier(forIndexPath indexPath: NSIndexPath) -> String {
        return "identifier"
    }
    
    func configure(cell cell: UICollectionViewCell, forItem item: ItemType, inCollectionView collectionView: UICollectionView) -> UICollectionViewCell {
        cell.contentView.backgroundColor = item
        return cell
    }
}


class CollectionViewDataSourceableSpec: QuickSpec {
    override func spec() {
        describe("CollectionViewDataSourceable") {
            let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
            collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "identifier")
            context("with a simple tableview data source") {
                let simpleDataSource = SimpleCollectionViewDataSource()
                let proxy = CollectionViewDataSourceProxy(dataSource: simpleDataSource)
                beforeEach {
                    collectionView.dataSource = proxy
                }
                describe("collectionView(collectionView: UICollectionView, numberOfRowsInSection section: Int) -> Int") {
                    it("should return 0 rows for section 0") {
                        expect(collectionView.dataSource!.collectionView(collectionView, numberOfItemsInSection: 0)).to(equal(3))
                    }
                }
                describe("numberOfSectionsInCollectionView") {
                    it("should return 0") {
                        expect(collectionView.dataSource!.numberOfSectionsInCollectionView!(collectionView)).to(equal(3))
                    }
                }
                
                describe("cellForItemAtIndexPath") {
                    it("should return the configured cell") {
                        for section in 0..<collectionView.dataSource!.numberOfSectionsInCollectionView!(collectionView) {
                            for row in 0..<collectionView.dataSource!.collectionView(collectionView, numberOfItemsInSection: section) {
                                let indexPath = NSIndexPath(forRow: row, inSection: section)
                                let cell = collectionView.dataSource!.collectionView(collectionView, cellForItemAtIndexPath:indexPath)
                                expect(cell.contentView.backgroundColor).to(equal(simpleDataSource.sections![section][row]))
                            }
                        }
                    }
                    it("should return an unconfigured cell for a non-existing indexpath") {
                        let cell = collectionView.dataSource!.collectionView(collectionView, cellForItemAtIndexPath:(NSIndexPath(forRow: 6, inSection: 6)))
                        expect(cell.contentView.backgroundColor).to(beNil())
                    }
                    
                }
            }
        }
        
    }
}