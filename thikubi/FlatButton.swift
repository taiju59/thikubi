//
//  FlatButton.swift
//  thikubi
//
//  Created by Taiju Aoki on 2015/12/22.
//  Copyright © 2015年 Taiju Aoki. All rights reserved.
//

import UIKit

class FlatButton: UIButton {

    private var defaultBackGroundColor: UIColor?  {
        get {
            return self.titleColorForState(.Highlighted)
        }
    }
    
    private var defaultTitleColor: UIColor?   {
        get {
            return self.titleColorForState(.Normal)
        }
    }
    
    @IBInspectable var borderColor : UIColor? {
        get {
            return UIColor(CGColor: super.layer.borderColor ?? UIColor().CGColor)
        }
        set {
            let value = newValue
            super.layer.borderColor = value?.CGColor
        }
    }
    
    @IBInspectable var borderWidth : CGFloat {
        get {
            return super.layer.borderWidth
        }
        set {
            let value = newValue
                super.layer.borderWidth = value
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat {
        get {
            return super.layer.cornerRadius
        }
        set {
            let value = newValue
            super.layer.cornerRadius = value
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.backgroundColor = self.defaultTitleColor
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        self.backgroundColor = self.defaultBackGroundColor
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
        self.backgroundColor = self.defaultBackGroundColor
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        if self.state != .Highlighted {
            self.backgroundColor = self.defaultBackGroundColor
        }
    }
    
}
