//
//  GCDPratice.swift
//  LBACode
//
//  Created by Little_beta on 2024/7/28.
//

import Foundation
import Dispatch

class GCDPratice: Testable {
    
    func testMethod() {
        testFunc1()
    }
        
    /// result: 1 5 2 4 3
    func testFunc1() -> Void {
        let queue: DispatchQueue = DispatchQueue(label: "concurrent", attributes: DispatchQueue.Attributes.concurrent)
        print(1)
        queue.async {
            print(2)
            queue.async {
                print(3)
            }
            print(4)
        }
        print(5)
    }
    
    /// result: 1 5 2 死锁
    func testFunc2() -> Void {
        let queue: DispatchQueue = DispatchQueue(label: "serial")
        print(1)
        queue.async {
            print(2)
            queue.sync {
                print(3)
            }
            print(4)
        }
        print(5)
    }
    
    /// result: 3 > 0 > 9，其他顺序不定
    func testFunc3() -> Void {
        let queue: DispatchQueue = DispatchQueue(label: "concurrent", attributes: DispatchQueue.Attributes.concurrent)
        queue.async {
            print(1)
        }
        queue.async {
            print(2)
        }
        queue.sync {
            print(3)
        }
        print(0)
        queue.async {
            print(7)
        }
        queue.async {
            print(8)
        }
        queue.sync {
            print(9)
        }
        
    }
    
    func testFunc4() -> Void {
        var a = 0
        while (a < 5) {
            DispatchQueue.global(qos: .userInteractive).async {
                print("\(a) - \(Thread.current)")
                a += 1
            }
        }
        print(a)
    }
    
    func testFunc5() -> Void {
        var a = 0
        while (a < 5) {
            DispatchQueue.global(qos: .background).async {
                for _ in 0..<1000 {
                    
                }
                a += 1
                print("\(a) - \(Thread.current)")
            }
        }
        DispatchQueue.global(qos: .userInteractive).async {
            print("\(a) ---------- \(Thread.current)")
        }
    }
}


