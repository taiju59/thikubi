//
//  Utils.swift
//  thikubi
//
//  Created by Taiju Aoki on 2016/01/29.
//  Copyright © 2016年 Taiju Aoki. All rights reserved.
//

import UIKit
import GameKit

class Utils {
    
    static func scoreToColor(score: Int) -> UIColor {
        
        var chikubiColor: UIColor!
        // 茶色->ピンク色にするための調整
        let adjust: Int = (NORMAL_SCORE - EASY_SCORE)/20
        if score <= EASY_SCORE {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 30)/255, blue:(CGFloat(score) - 50)/255, alpha:1.0)
        } else if EASY_SCORE < score && score < EASY_SCORE + adjust*1 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 35)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*1 <= score && score < EASY_SCORE + adjust*2 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 40)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*2 <= score && score < EASY_SCORE + adjust*3 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 45)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*3 <= score && score < EASY_SCORE + adjust*4 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 50)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*4 <= score && score < EASY_SCORE + adjust*5 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 55)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*5 <= score && score < EASY_SCORE + adjust*6 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 60)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*6 <= score && score < EASY_SCORE + adjust*7 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 65)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*7 <= score && score < EASY_SCORE + adjust*8 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 70)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*8 <= score && score < EASY_SCORE + adjust*9 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 75)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*9 <= score && score < EASY_SCORE + adjust*10 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 80)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*10 <= score && score < EASY_SCORE + adjust*11 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 85)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*11 <= score && score < EASY_SCORE + adjust*12 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 90)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*12 <= score && score < EASY_SCORE + adjust*13 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 95)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*13 <= score && score < EASY_SCORE + adjust*14 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 100)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*14 <= score && score < EASY_SCORE + adjust*15 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 105)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*15 <= score && score < EASY_SCORE + adjust*16 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 110)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*16 <= score && score < EASY_SCORE + adjust*17 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 115)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*17 <= score && score < EASY_SCORE + adjust*18 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 120)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*18 <= score && score < EASY_SCORE + adjust*19 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 125)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*19 <= score && score < EASY_SCORE + adjust*20 {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 130)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else if EASY_SCORE + adjust*20 <= score && score < NORMAL_SCORE {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 145)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        } else {
            chikubiColor = UIColor(red:CGFloat(score)/255, green:(CGFloat(score) - 148)/255, blue:(CGFloat(score) - 49)/255, alpha:1.0)
        }
        
        return chikubiColor
    }
    
    static func getPointLabel(mode: Mode, route: TouchType, point: Int) -> UILabel {
        
        var strPoint: String!
        
        // 見た目上の数値を操作
        switch mode {
        case .Easy:
            strPoint = String(point * 5 / 2)
        case .Normal:
            strPoint = String(point * 5)
        case .Hard:
            strPoint = String(point * 10)
        }
        
        // テキスト＆文字色設定
        var pointColor: UIColor = UIColor()
        switch route {
        case .Chikubi:
            strPoint = "+ " +  strPoint
            pointColor = UIColor.whiteColor()
        case .Around:
            strPoint = "+ " +  strPoint
            pointColor = UIColor(red:255/255, green:107/255, blue:206/255, alpha:1.0)
        case .Outside:
            strPoint = "- " +  strPoint
            pointColor = UIColor.blackColor()
        }
        
        let fontSize: CGFloat = (route == .Chikubi) ? 160:70
        let attrStr_point: NSMutableAttributedString = NSMutableAttributedString(string: strPoint)
        let attributes: [String : AnyObject] = [
            NSFontAttributeName: UIFont(name: "Futura-CondensedMedium", size: fontSize)!,
            NSStrokeWidthAttributeName: 5,
            NSStrokeColorAttributeName: pointColor,
        ]
        attrStr_point.addAttributes(attributes, range:NSMakeRange(0, attrStr_point.length))
        
        let pointLabel: UILabel = UILabel()
        pointLabel.adjustsFontSizeToFitWidth = true
        pointLabel.attributedText = attrStr_point
        pointLabel.frame = CGRectMake(0, 0, 320, 160)
        pointLabel.textAlignment = NSTextAlignment.Center
        
        return pointLabel
    }
    
    static func getGameOverStr(mode: Mode) -> String {
        
        let textArray1 = [
            String(localizeKey: Keys.GAME_OVER_STR + "1"),
            String(localizeKey: Keys.GAME_OVER_STR + "2"),
            String(localizeKey: Keys.GAME_OVER_STR + "3"),
            String(localizeKey: Keys.GAME_OVER_STR + "4"),
            String(localizeKey: Keys.GAME_OVER_STR + "5"),
            String(localizeKey: Keys.GAME_OVER_STR + "6"),
            String(localizeKey: Keys.GAME_OVER_STR + "7")
        ]
        
        let textArray2 = [
            String(localizeKey: Keys.CHIKUBI_TRIVIA + "1"),
            String(localizeKey: Keys.CHIKUBI_TRIVIA + "2"),
            String(localizeKey: Keys.CHIKUBI_TRIVIA + "3"),
            String(localizeKey: Keys.CHIKUBI_TRIVIA + "4"),
            String(localizeKey: Keys.CHIKUBI_TRIVIA + "5"),
            String(localizeKey: Keys.CHIKUBI_TRIVIA + "6"),
            String(localizeKey: Keys.CHIKUBI_TRIVIA + "7"),
            String(localizeKey: Keys.CHIKUBI_TRIVIA + "8")
        ]
        
        let textArray3 = [
            String(localizeKey: Keys.CHIKUBI_TRIVIA + "9"),
            String(localizeKey: Keys.CHIKUBI_TRIVIA + "10"),
            String(localizeKey: Keys.CHIKUBI_TRIVIA + "11"),
            String(localizeKey: Keys.CHIKUBI_TRIVIA + "12"),
            String(localizeKey: Keys.CHIKUBI_TRIVIA + "13"),
            String(localizeKey: Keys.CHIKUBI_TRIVIA + "14"),
            String(localizeKey: Keys.CHIKUBI_TRIVIA + "15"),
            String(localizeKey: Keys.CHIKUBI_TRIVIA + "16"),
            String(localizeKey: Keys.CHIKUBI_TRIVIA + "17")
        ]
        
        
        // コンプリートチェック用
        var easy_dic: [String:String] = [:]
        var normal_dic: [String:String] = [:]
        var hard_dic: [String:String] = [:]
        if let ed = userDefaults.objectForKey(Keys.EASY_DIC) {
            easy_dic = ed as! [String : String]
        }
        if let nd = userDefaults.objectForKey(Keys.NORMAL_DIC) {
            normal_dic = nd as! [String : String]
        }
        if let hd = userDefaults.objectForKey(Keys.HARD_DIC) {
            hard_dic = hd as! [String : String]
        }
        
        var game_over_str: String = ""
        switch mode {
        case .Easy:
            let rand: UInt32 = arc4random() % UInt32(textArray1.count)
            game_over_str = textArray1[Int(rand)]
            // コンプリートチェック用
            let randStr: String = "\(rand + 1)" // 0はなんとなくよくないので+1しとく
            easy_dic[randStr] = "1"
            userDefaults.setObject(easy_dic, forKey:Keys.EASY_DIC)
        case .Normal:
            let rand: UInt32 = arc4random() % UInt32(textArray2.count)
            game_over_str = textArray2[Int(rand)]
            // コンプリートチェック用
            let randStr: String = "\(rand + 1)" // 0はなんとなくよくないので+1しとく
            normal_dic[randStr] = "1"
            userDefaults.setObject(normal_dic, forKey:Keys.NORMAL_DIC)
        case .Hard:
            let rand: UInt32 = arc4random() % UInt32(textArray3.count)
            game_over_str = textArray3[Int(rand)]
            // コンプリートチェック用
            let randStr: String = "\(rand + 1)" // 0はなんとなくよくないので+1しとく
            hard_dic[randStr] = "1"
            userDefaults.setObject(hard_dic, forKey:Keys.HARD_DIC)
        }
        userDefaults.synchronize()
        // コンプリートチェック
        let easy_complete: Bool = easy_dic.count >= textArray1.count
        let normal_complete: Bool = normal_dic.count >= textArray2.count
        let hard_complete: Bool = hard_dic.count >= textArray3.count
        if easy_complete && normal_complete && hard_complete {
            reportAchievementIdentifier("game_over", percentComplete:100)
        }
        
        return game_over_str
    }
    
    // achievement送信
    private static func reportAchievementIdentifier(identifier: String, percentComplete percent: Float) {
        
        let achievement: GKAchievement = GKAchievement(identifier:identifier)
        achievement.percentComplete = Double(percent)
        GKAchievement.reportAchievements([achievement], withCompletionHandler:  {
            (error:NSError?) -> Void in
            if error != nil { print("error: \(error)") }
        })
    }

    
}