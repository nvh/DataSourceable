//
//  TableViewDataSource.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 13/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public protocol TableViewCellProviding {
    typealias ItemType
    func reuseIdentifier(forIndexPath indexPath: NSIndexPath) -> String
    func configure(cell cell: UITableViewCell, forItem item: ItemType, inTableView tableView: UITableView) -> UITableViewCell
}

public protocol TableViewDataSourceable: Sectionable, TableViewCellProviding {
    func tableView(tableView: UITableView, titleForHeaderInSection sectionIndex: Int) -> String?
    func tableView(tableView: UITableView, titleForFooterInSection sectionIndex: Int) -> String?
}

public extension TableViewDataSourceable where ItemType == Section.Data._Element, Section.Data.Index == Int {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems(inSection: section)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = reuseIdentifier(forIndexPath: indexPath)
        guard let itemAtIndexPath = item(atIndexPath: indexPath) else {
            return tableView.dequeueReusableCellWithIdentifier(identifier)!
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        configure(cell: cell, forItem: itemAtIndexPath, inTableView: tableView)
        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return numberOfSections
    }

    func tableView(tableView: UITableView, titleForHeaderInSection sectionIndex: Int) -> String? {
        return section(atIndex: sectionIndex)?.headerTitle
    }

    func tableView(tableView: UITableView, titleForFooterInSection sectionIndex: Int) -> String? {
        return section(atIndex: sectionIndex)?.footerTitle
    }
}


//This could just be a protocol extension if UITableViewDatasSource wouldn't enforce @objc
public class TableViewDataSourceProxy<D: TableViewDataSourceable where D.ItemType == D.Section.Data._Element, D.Section.Data.Index == Int>: NSObject, UITableViewDataSource {
    public var dataSource: D
    
    public init(dataSource: D) {
        self.dataSource = dataSource
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.tableView(tableView, numberOfRowsInSection: section)
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return dataSource.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.numberOfSectionsInTableView(tableView)
    }
    
    public func tableView(tableView: UITableView, titleForHeaderInSection sectionIndex: Int) -> String? {
        return dataSource.tableView(tableView, titleForHeaderInSection: sectionIndex)
    }
    
    public func tableView(tableView: UITableView, titleForFooterInSection sectionIndex: Int) -> String? {
        return dataSource.tableView(tableView, titleForFooterInSection: sectionIndex)
    }
}
