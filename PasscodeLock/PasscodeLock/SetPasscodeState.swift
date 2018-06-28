//
//  SetPasscodeState.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/28/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

public struct SetPasscodeState: PasscodeLockStateType {
    
    public let title: String
    public let description: String
    public let stringsForState: LocalizedStringsForConfirm
    public let isCancellableAction = true
    public var isTouchIDAllowed = false

    public init(strings: LocalizedStringsForConfirm, tryAgain: Bool) {
        stringsForState = strings
        if tryAgain {
            title = strings.tryAgainTitle
            description = strings.tryAgainDescription
        } else {
            title = strings.title
            description = strings.description
        }
    }
    
    public func acceptPasscode(_ passcode: [String], fromLock lock: PasscodeLockType) {
        
        let nextState = ConfirmPasscodeState(passcode: passcode, strings: stringsForState)
        
        lock.changeStateTo(nextState)
    }
}
