//
//  Sectionable.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 13/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//
import Foundation
import DataSourceable
import Quick
import Nimble

struct SingleSectionDataSource: Sectionable, DataSourceType {
    typealias Data =  [Int]
    typealias Section = Data
    var data: Data? = nil
}


struct SectionableDataSource: Sectionable, DataSourceType {
    typealias Data =  [Section]
    typealias Section = [Int]
    var data: Data? = nil
}

class SectionableSpec: QuickSpec {
    override func spec() {
        describe("Sectionable") {
            var sectionable: SectionableDataSource!
            context("data is nil") {
                beforeEach {
                    sectionable = SectionableDataSource(data: nil)
                }
                
                it("sections is nil") {
                    expect(sectionable.sections).to(beNil())
                }
                it("numberOfSections to be 0") {
                    expect(sectionable.numberOfSections).to(equal(0))
                }
                
                it("should return an item count of 0") {
                    expect(sectionable.numberOfItems(inSection: 0)).to(equal(0))
                }
            }
            
            context("data is set") {
                let data = [[3,5,7,9],[2,4,6]]
                beforeEach {
                    sectionable = SectionableDataSource(data: data)
                }
                it("should return two sections") {
                    expect(sectionable.numberOfSections).to(equal(data.count))
                }
                it("should return the right number of items") {
                    expect(sectionable.numberOfItems(inSection: 0)).to(equal(data[0].count))
                }
                it("should return the right items") {
                    for sectionIndex in 0..<sectionable.numberOfSections {
                        for index in 0..<sectionable.numberOfItems(inSection: sectionIndex) {
                        expect(sectionable.item(atIndexPath: NSIndexPath(forItem: index, inSection: sectionIndex))).to(equal(data[sectionIndex][index]))
                        }
                    }
                    
                }
            }
            
            context("single section datasource") {
                var singleSection: SingleSectionDataSource!
                let data = [3,1,4,1,5]
                beforeEach {
                    singleSection = SingleSectionDataSource(data: data)
                }
                
                it("should return one section") {
                    expect(singleSection.numberOfSections).to(equal(1))
                }
                
                it("should return the data count for the first section") {
                    expect(singleSection.numberOfItems(inSection: 0)).to(equal(data.count))
                }
                
                it("should return the contents of data for the first section") {
                    for (index,value) in data.enumerate() {
                        expect(singleSection.item(atIndexPath: NSIndexPath(forItem: index, inSection: 0))).to(equal(value))
                    }
                }
            }
            
        }
    }
}
