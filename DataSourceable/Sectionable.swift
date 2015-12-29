//
//  SectionableDataSource.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 13/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public protocol Sectionable {
    typealias Section: SectionType
    var sections: [Section]? { get }
}

public protocol SectionCreating: Sectionable {
    typealias Data
    var data: Data? { get }
    func createSections(data: Data) -> [Section]
}

public extension Sectionable {
    var numberOfSections: Int {
        return sections?.count ?? 0
    }
    
    func section(atIndex sectionIndex: Int) -> Section? {
        guard sectionIndex < numberOfSections else {
            return nil
        }
        return sections?[sectionIndex]
    }
    
    func numberOfItems(inSection sectionIndex: Int) -> Int {
        return section(atIndex: sectionIndex)?.numberOfItems ?? 0
    }

    func item(atIndexPath indexPath: NSIndexPath) -> Section.Data.Element? {
        return section(atIndex: indexPath.section)?.item(atIndex: indexPath.row)
    }
}

public extension Sectionable where Self : SectionCreating {
    var sections: [Section]? {
        return data.map(createSections)
    }
}

public extension Sectionable where Self : DataContaining, Section == Self.Data {
    var sections: [Section]? {
        return data.map { [$0] }
    }
}

public extension Sectionable where Self : DataContaining, Self.Data == [Section] {
    var sections: [Section]? {
        return data
    }
}