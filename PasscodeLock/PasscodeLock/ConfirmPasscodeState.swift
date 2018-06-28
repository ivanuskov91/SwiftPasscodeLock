//
//  ConfirmPasscodeState.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/28/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

public struct ConfirmPasscodeState: PasscodeLockStateType {
    
    public let title: String
    public let description: String
    public let stringsForState: LocalizedStringsForConfirm
    public let isCancellableAction = true
    public var isTouchIDAllowed = false
    
    fileprivate var passcodeToConfirm: [String]

    public init(passcode: [String], strings: LocalizedStringsForConfirm) {
        stringsForState = strings
        passcodeToConfirm = passcode
        title = strings.confirmTitle
        description = strings.confirmDescription
    }
    
    public func acceptPasscode(_ passcode: [String], fromLock lock: PasscodeLockType) {
        
        if passcode == passcodeToConfirm {
            
            lock.repository.savePasscode(passcode)
            lock.delegate?.passcodeLockDidSucceed(lock)
        
        } else {
            
            let nextState = SetPasscodeState(strings: stringsForState, tryAgain: true)
            
            lock.changeStateTo(nextState)
            lock.delegate?.passcodeLockDidFail(lock)
        }
    }
}
