//
//  TestQueue.swift
//  LBACode
//
//  Created by Little_beta on 2024/8/4.
//

import Foundation

protocol Testable {
    func testMethod()
}

class TestQueue
{
    var queue: [Testable] = []
    
    func addElement(ele: Testable) {
        queue.append(ele)
    }
    
    func addElments(eles: [Testable]) {
        queue += eles
    }
    
    func runTest() {
        queue.forEach { Testable in
            Testable.testMethod()
        }
    }
    
    static func test() {
        let testQueue: TestQueue = TestQueue()
        testQueue.addElments(eles: [GCDPratice()])
        testQueue.runTest()
        Thread.sleep(forTimeInterval: 10)
    }
}

