//
//  MemoryLeakConfiguration.swift
//  PraceZaRohem
//
//  Created by Tomas Kohout on 1/31/16.
//  Copyright © 2016 Ackee s.r.o. All rights reserved.
//
import Quick
import Nimble

let objectKey = "factory"

//Checks whether object gets properly deallocated
// Usage:
//itBehavesLike("object without leaks"){
//    NSDictionary{
//         ObjectToCheck( ... )
//    }
//}

class MemoryLeakConfiguration: QuickConfiguration {
    override class func configure(_ configuration: Configuration) {
        sharedExamples("object without leaks") { (sharedExampleContext: @escaping SharedExampleContext) in
            it("gets deallocated") {
                var object: AnyObject? = sharedExampleContext().objectCreate()

                weak var ref = object
                object = nil

                expect(ref).toEventually(beNil(), description: "Memory leak detected on \(ref)")
            }
        }
    }
}

// Workaround to pass closure in NSDictionary (SharedExampleContext)
// Hopefully they will switch to swift soon
typealias MemoryLeakContext = NSDictionary
extension NSDictionary {
    fileprivate class ClosureWrapper {
        fileprivate let closure: () -> AnyObject

        init(closure: @escaping () -> AnyObject) {
            self.closure = closure
        }

        func create() -> AnyObject {
            return self.closure()
        }
    }

    convenience init(objectClosure: @escaping () -> AnyObject) {
        self.init(dictionary: [objectKey: ClosureWrapper(closure: objectClosure)])
    }

    func objectCreate() -> AnyObject {
        return (self[objectKey] as! ClosureWrapper).create()
    }
}
