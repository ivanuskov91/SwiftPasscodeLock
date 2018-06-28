//
//  PasscodeSignPlaceholderView.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/28/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import UIKit

@IBDesignable
public class PasscodeSignPlaceholderView: UIView {
    
    public enum State {
        case inactive
        case active
        case error
    }
    
    @IBInspectable
    public var inactiveColor: UIColor = UIColor.clear {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable
    public var activeColor: UIColor = UIColor.white {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable
    public var errorColor: UIColor = UIColor.white {
        didSet {
            setupView()
        }
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    public override var intrinsicContentSize : CGSize {
        
        return CGSize(width: 13, height: 13)
    }
    
    fileprivate func setupView() {
        
        layer.cornerRadius = 8
        layer.borderWidth = 2
        layer.borderColor = activeColor.cgColor
        backgroundColor = inactiveColor
    }
    
    fileprivate func colorsForState(_ state: State) -> (backgroundColor: UIColor, borderColor: UIColor) {
        
        switch state {
        case .inactive: return (inactiveColor, activeColor)
        case .active: return (activeColor, activeColor)
        case .error: return (errorColor, errorColor)
        }
    }
    
    public func animateState(_ state: State) {
        
        let colors = colorsForState(state)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: [],
            animations: {
                
                self.backgroundColor = colors.backgroundColor
                self.layer.borderColor = colors.borderColor.cgColor
                
            },
            completion: nil
        )
    }
}
