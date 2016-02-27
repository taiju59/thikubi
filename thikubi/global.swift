//
//  global.swift
//  thikubi
//
//  Created by Taiju Aoki on 2015/10/23.
//  Copyright © 2015年 Taiju Aoki. All rights reserved.
//

import UIKit
import AVFoundation

/*--------------------------------------------------
変数
--------------------------------------------------*/

var choiceColorNum = 1
var voice1 = DEFAULT_GOOD_VOICE
var voice2 = DEFAULT_GREAT_VOICE
var yomiage = AVSpeechSynthesizer()
var useSound = true

var sSecond = 0
var second = 0

let userDefaults = NSUserDefaults.standardUserDefaults()

func RGB(r: Int, g: Int, b: Int) -> UIColor {
    return UIColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1.0)
}

func RGBA(r: Int, g: Int, b: Int, a: CGFloat) -> UIColor {
    return UIColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: a)
}

func ICON_FONT(size: CGFloat) -> UIFont {
    return UIFont(name: "icomoon", size: size)!
}

extension String {
    init(localizeKey: String, _ arguments: CVarArgType...)  {
        if arguments.count == 1 {
            self = String.localizedStringWithFormat(NSLocalizedString(localizeKey, comment: ""), arguments[0])
        } else if arguments.count == 2 {
            self = String.localizedStringWithFormat(NSLocalizedString(localizeKey, comment: ""), arguments[0], arguments[1])
        } else if arguments.count == 3 {
            self = String.localizedStringWithFormat(NSLocalizedString(localizeKey, comment: ""), arguments[0], arguments[1], arguments[2])
        } else {
            self = String.localizedStringWithFormat(NSLocalizedString(localizeKey, comment: ""))
        }
    }
}