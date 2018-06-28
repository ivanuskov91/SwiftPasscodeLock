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
    public let stringsForState: LocalizedStringsForConfirm
    public let isCancellableAction = true
    public var isTouchIDAllowed = false
    
    public init(strings: LocalizedStringsForConfirm) {
        stringsForState = strings
        
        title = stringsForState.changeTitle
        description = stringsForState.changeDescription
    }
    
    public func acceptPasscode(_ passcode: [String], fromLock lock: PasscodeLockType) {
        
        guard let currentPasscode = lock.repository.passcode else {
            return
        }
        
        if passcode == currentPasscode {
            
            let nextState = SetPasscodeState(strings: stringsForState, tryAgain: false)
            
            lock.changeStateTo(nextState)
            
        } else {
            
            lock.delegate?.passcodeLockDidFail(lock)
        }
    }
}
