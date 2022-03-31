//
//  PublisherExtensionsTests.swift
//  ACKategoriesCoreTests
//
//  Created by Vendula Švastalová on 31.03.2022.
//

import XCTest
import ACKategoriesCore
import Combine

final class PublisherExtensionsTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    func testZippingAndNeverReceiving() {
        let p1 = PassthroughSubject<Int, Never>()
        let p2 = PassthroughSubject<Int, Never>()
        
        let zipMany = Publishers.ZipMany(p1, p2)
        
        var values: [[Int]] = []
        zipMany
            .sink { values.append($0) }
            .store(in: &cancellables)
        
        p1.send(1)
        p1.send(2)
        p1.send(22)
        p1.send(1)
        
        XCTAssertEqual(
            values,
            []
        )
    }
    
    func testZippingPassthroughSubject() {
        let p1 = PassthroughSubject<Int, Never>()
        let p2 = PassthroughSubject<Int, Never>()
        
        let zipMany = Publishers.ZipMany(p1, p2)
        
        var values: [[Int]] = []
        zipMany
            .sink { values.append($0) }
            .store(in: &cancellables)
        
        p1.send(1)
        p2.send(2)
        
        p1.send(2)
        p2.send(3)
        
        p2.send(33)
        p1.send(22)
        
        p1.send(1)
        
        XCTAssertEqual(
            values,
            [
                [1,2],
                [2,3],
                [22,33]
            ]
        )
    }
    
    func testZippingCurrentValueSubjects() {
        let c1 = CurrentValueSubject<Int, Never>(0)
        let c2 = CurrentValueSubject<Int, Never>(0)
        
        let zipMany = Publishers.ZipMany(c1, c2)
        
        var values: [[Int]] = []
        zipMany
            .sink { values.append($0) }
            .store(in: &cancellables)
        
        c1.send(1)
        c2.send(2)
        
        c1.send(2)
        c2.send(3)
        
        c1.send(22)
        c2.send(33)
        
        c1.send(1)
        
        XCTAssertEqual(
            values,
            [
                [0,0],
                [1,2],
                [2,3],
                [22,33]
            ]
        )
    }
    
    func testZippingJusts() {
        let j1 = Just(1)
        let j2 = Just(2)
        
        let zipMany = Publishers.ZipMany(j1, j2)
        
        var values: [[Int]] = []
        zipMany
            .sink { values.append($0) }
            .store(in: &cancellables)
        
        XCTAssertEqual(
            values,
            [
                [1,2]
            ]
        )
    }
    
    func testZippingSinglePublisher() {
        let p1 = PassthroughSubject<Int, Never>()
        
        let zipMany = Publishers.ZipMany(p1)
        
        var values: [[Int]] = []
        zipMany
            .sink { values.append($0) }
            .store(in: &cancellables)
        
        p1.send(1)
        p1.send(2)
        p1.send(22)
        p1.send(1)
        
        XCTAssertEqual(
            values,
            [
                [1],
                [2],
                [22],
                [1]
            ]
        )
    }
    
    func testZippingZeroPublishers() {
        let zipMany = Publishers.ZipMany([Just<Int>]())
        
        var values: [[Int]] = []
        zipMany
            .sink { values.append($0) }
            .store(in: &cancellables)
        
        XCTAssertEqual(
            values,
            [[]]
        )
    }
    
    func testZipManyCompletesWhenOnePublisherCompletes() {
        let c1 = CurrentValueSubject<Int, Never>(0)
        let c2 = CurrentValueSubject<Int, Never>(0)
        
        let zipMany = Publishers.ZipMany(c1, c2)
        
        var didComplete: Bool = false
        zipMany
            .sink(receiveCompletion: { _ in didComplete = true }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        c1.send(1)
        c2.send(2)
        
        c1.send(completion: .finished)
        
        XCTAssertTrue(didComplete)
    }
}
