//
//  SystemManager.swift
//  thikubi
//
//  Created by Taiju Aoki on 2016/01/30.
//  Copyright © 2016年 Taiju Aoki. All rights reserved.
//

import Foundation


class SystemManager {
    
    static let sharedInstance = SystemManager()
    
    var combo: Int = 0
    var up: Int = 0
    var down: Int = 0
    var nowMode: Mode = .Easy
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
        case .Easy:
            up      = EASY_UP
            down    = EASY_DOWN
        case .Normal:
            up      = NORMAL_UP
            down    = NORMAL_DOWN
        case .Hard:
            up      = HARD_UP
            down    = HARD_DOWN
        }
    }
    
    func modeReset() {
        nowMode = .Easy
        score = 0
        combo = 0
        touchCount = 0
        under_combo = 0
    }
    
    func touched(type: TouchType) {
        switch type {
        case .Chikubi:
            if nowMode == .Easy && (score + up*(2 + combo)) > EASY_SCORE {
                score = EASY_SCORE
            } else if nowMode == .Normal && (score + up*(2 + combo)) > NORMAL_SCORE {
                score = NORMAL_SCORE
            } else {
                score += up*(2 + combo);
            }
        case .Around:
            combo = 0
            // クリア値を超えないようにする
            if (nowMode == .Easy && (score + up) > EASY_SCORE) {
                score = EASY_SCORE
            } else if nowMode == .Normal && score + up > NORMAL_SCORE {
                score = NORMAL_SCORE
            } else {
                score += up;
            }
        case .Outside:
            combo = 0
            under_combo++
            // MainViewControllerにて処理
        }
    }
    
    // モードクリア判定
    func clearCheck() -> Bool {
        switch nowMode {
        case .Easy:
            return score >= EASY_SCORE
        case .Normal:
            return score >= NORMAL_SCORE
        case .Hard:
            return score >= HARD_SCORE
        }
    }
    
    static func getClearColor(clearedMode: Mode) -> (UIColor, String) {
        var color: UIColor!
        var string: String!
        switch clearedMode {
        case .Easy:
            color = UIColor.whiteColor()
            string = String(localizeKey: Keys.CLEAR_COLOR_EASY)
        case .Normal:
            color = UIColor.darkGrayColor()//blackColor()
            string = String(localizeKey: Keys.CLEAR_COLOR_NORMAL)
        case .Hard:
            color = UIColor(red:278/255, green:130/255, blue:229/255, alpha:1.0)
            string = String(localizeKey: Keys.CLEAR_COLOR_HARD)
        }
        
        return (color, string)
    }
    
    func isTimeUp(second: Int) -> Bool {
        switch nowMode {
        case .Easy:
            return EASY_NEXT_TIME <= second
        case .Normal:
            return NORMAL_NEXT_TIME <= second
        case .Hard:
            return HARD_NEXT_TIME <= second
        }
    }

    
}

enum Mode {
    
    case Easy
    case Normal
    case Hard
}

enum TouchType {
    
    case Chikubi
    case Around
    case Outside
}









