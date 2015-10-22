//
//  SectionType.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 13/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public protocol SectionType: DataSourceType {
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

extension Array: SectionType {}