//
//  ChangePasscodeState.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/28/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

public struct ChangePasscodeState: PasscodeLockStateType {
    
    public let title: String
    public let description: String
    public let isCancellableAction = true
    public var isTouchIDAllowed = false
    
    public init() {
        
        title = localizedStringFor("PasscodeLockChangeTitle", comment: "Change passcode title")
        description = localizedStringFor("PasscodeLockChangeDescription", comment: "Change passcode description")
    }
    
    public func acceptPasscode(_ passcode: [String], fromLock lock: PasscodeLockType) {
        
        guard let currentPasscode = lock.repository.passcode else {
            return
        }
        
        if passcode == currentPasscode {
            
            let nextState = SetPasscodeState()
            
            lock.changeStateTo(nextState)
            
        } else {
            
            lock.delegate?.passcodeLockDidFail(lock)
        }
    }
}
