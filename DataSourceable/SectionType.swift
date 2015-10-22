//
//  SectionType.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 13/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public protocol SectionType: DataSourceType, Indexable {
    var headerTitle: String? { get }
    var footerTitle: String? { get }
}

public extension SectionType {
    var headerTitle: String? { return nil }
    var footerTitle: String? { return nil }
}

public extension SectionType where Self == Data {
    var data: Data? {
        return self
    }
}

public protocol StaticSectionType: SectionType {
    var staticData: Data { get }
}

public extension StaticSectionType {
    var data: Data? {
        return staticData
    }
}

public extension StaticSectionType where Self.Index == Self.Data.Index, Self._Element == Self.Data._Element {
    var startIndex: Self.Index {
        return staticData.startIndex
    }
    var endIndex: Self.Index {
        return staticData.endIndex
    }
    subscript(position: Self.Index) -> Self._Element {
        return staticData[position]
    }
}

extension Array: SectionType {}