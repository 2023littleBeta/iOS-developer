//
//  CommonCode.swift
//  LBACode
//
//  Created by Little_beta on 2024/8/4.
//

import Foundation

// MARK: - Once
public final class Once {
private var _onceToken: Int = 0
private let _lock = NSRecursiveLock()

func execute(_ block: () -> Void) {
    _lock.lock()
    defer {
        _lock.unlock()
    }

    if _onceToken == 0 {
        _onceToken = 1
        block()
    }
}
}
