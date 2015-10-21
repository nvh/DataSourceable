//
//  SectionTypeSpec.swift
//  DataSourcable
//
//  Created by Niels van Hoorn on 13/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

import DataSourcable
import Quick
import Nimble

struct Section: StaticSectionType {
    typealias Data = [Int]
    typealias Index = Data.Index
    typealias _Element = Data.Index
    let staticData: Data
}

class SectionTypeSpec: QuickSpec {
    override func spec() {
        describe("SectionType") {
            let section =  Section(staticData: [0,0,7])
            describe("should act as a dataSource") {
                it("numberOfItems should return 0") {
                    expect(section.numberOfItems).to(equal(section.staticData.count))
                }
                
                it("should return nil when requesting a item at index") {
                    for index in section.startIndex..<section.endIndex {
                        expect(section.item(atIndex: index)).to(equal(section[index]))
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
