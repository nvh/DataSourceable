//
//  SectionTypeSpec.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 13/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

import DataSourceable
import Quick
import Nimble

struct Section: SectionType {
    typealias Data = [Int]
    typealias Index = Int
    typealias _Element = Data.Index
    let data: Data?
}

class SectionTypeSpec: QuickSpec {
    override func spec() {
        describe("SectionType") {
            let data = [0,0,7]
            let section =  Section(data: data)
            describe("should act as a dataSource") {
                it("numberOfItems should return 0") {
                    expect(section.numberOfItems).to(equal(3))
                }
                
                it("should return nil when requesting a item at index") {
                    for index in 0..<section.numberOfItems {
                        expect(section.item(atIndex: index)).to(equal(data[index]))
                    }
                }
            }
            describe("header and footer") {
                it("should have a header and a footer default value") {
                    expect(section.headerTitle).to(beNil())
                    expect(section.footerTitle).to(beNil())
                }
            }
        }
    }
}
