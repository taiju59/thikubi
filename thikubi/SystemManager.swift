//
//  SystemManager.swift
//  thikubi
//
//  Created by Taiju Aoki on 2016/01/30.
//  Copyright © 2016年 Taiju Aoki. All rights reserved.
//

import Foundation
import UIKit

class SystemManager {

    static let sharedInstance = SystemManager()

    var combo: Int = 0
    var up: Int = 0
    var down: Int = 0
    var nowMode: Mode = .easy
    var color_str: String = ""
    var score: Int = 0

    var touchCount: Int = 0
    var clearTouchCount: Int = 0
    var under_combo: Int = 0

    var clearedModeForPost: Mode!

    private init() {

    }

    func modeSetting() {
        switch nowMode {
        case .easy:
            up      = EASY_UP
            down    = EASY_DOWN
        case .normal:
            up      = NORMAL_UP
            down    = NORMAL_DOWN
        case .hard:
            up      = HARD_UP
            down    = HARD_DOWN
        }
    }

    func modeReset() {
        nowMode = .easy
        score = 0
        combo = 0
        touchCount = 0
        under_combo = 0
    }

    func touched(type: TouchType) {
        switch type {
        case .chikubi:
            if nowMode == .easy && (score + up*(2 + combo)) > EASY_SCORE {
                score = EASY_SCORE
            } else if nowMode == .normal && (score + up*(2 + combo)) > NORMAL_SCORE {
                score = NORMAL_SCORE
            } else {
                score += up*(2 + combo);
            }
        case .around:
            combo = 0
            // クリア値を超えないようにする
            if (nowMode == .easy && (score + up) > EASY_SCORE) {
                score = EASY_SCORE
            } else if nowMode == .normal && score + up > NORMAL_SCORE {
                score = NORMAL_SCORE
            } else {
                score += up;
            }
        case .outside:
            combo = 0
            under_combo += 1
            // MainViewControllerにて処理
        }
    }

    // モードクリア判定
    func clearCheck() -> Bool {
        switch nowMode {
        case .easy:
            return score >= EASY_SCORE
        case .normal:
            return score >= NORMAL_SCORE
        case .hard:
            return score >= HARD_SCORE
        }
    }

    static func getClearColor(clearedMode: Mode) -> (UIColor, String) {
        var color: UIColor!
        var string: String!
        switch clearedMode {
        case .easy:
            color = UIColor.white
            string = String(localizeKey: Keys.CLEAR_COLOR_EASY)
        case .normal:
            color = UIColor.darkGray//blackColor()
            string = String(localizeKey: Keys.CLEAR_COLOR_NORMAL)
        case .hard:
            color = UIColor(red:278/255, green:130/255, blue:229/255, alpha:1.0)
            string = String(localizeKey: Keys.CLEAR_COLOR_HARD)
        }

        return (color, string)
    }

    func isTimeUp(second: Int) -> Bool {
        switch nowMode {
        case .easy:
            return EASY_NEXT_TIME <= second
        case .normal:
            return NORMAL_NEXT_TIME <= second
        case .hard:
            return HARD_NEXT_TIME <= second
        }
    }


}

enum Mode {

    case easy
    case normal
    case hard
}

enum TouchType {

    case chikubi
    case around
    case outside
}









