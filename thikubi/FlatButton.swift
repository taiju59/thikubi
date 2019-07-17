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
            return self.titleColor(for: .highlighted)
        }
    }

    private var defaultTitleColor: UIColor?   {
        get {
            return self.titleColor(for: .normal)
        }
    }

    @IBInspectable var borderColor : UIColor? {
        get {
            return UIColor(cgColor: super.layer.borderColor ?? UIColor().cgColor)
        }
        set {
            let value = newValue
            super.layer.borderColor = value?.cgColor
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        self.backgroundColor = self.defaultTitleColor
        super.touchesBegan(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.backgroundColor = self.defaultBackGroundColor
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.backgroundColor = self.defaultBackGroundColor
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if self.state != .highlighted {
            self.backgroundColor = self.defaultBackGroundColor
        }
    }

}
