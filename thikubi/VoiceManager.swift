//
//  VoiceManager.swift
//  thikubi
//
//  Created by Taiju Aoki on 2015/10/05.
//  Copyright © 2015年 Taiju Aoki. All rights reserved.
//

import UIKit
import AVFoundation

class VoiceManager {
    
    class func voice(yomiageStr:String) {
        if useSound {
            yomiage.stopSpeakingAtBoundary(.Immediate)
            yomiage = AVSpeechSynthesizer()
            
            var pitch: Float = 5
            
            if yomiageStr == "tくび" && !before_iPhone6() {
                pitch = 1.3
            }
            let utterance = AVSpeechUtterance(string: yomiageStr)
            utterance.voice =  AVSpeechSynthesisVoice(language: checkLanguage(yomiageStr))
            utterance.rate = 0.7 // はやさ
            utterance.pitchMultiplier = pitch; // 声のピッチ
            yomiage.speakUtterance(utterance)
            
        }
    }
    
    class func checkLanguage(yomiageStr: String) -> String {
        var language = ""
        
        // 検索する文字列
        let string = yomiageStr
        
        // 正規表現オブジェクト作成(日本語を含む)
        var regex = NSRegularExpression()
        do {
            regex = try NSRegularExpression(pattern: "[亜-熙ぁ-んァ-ヶ]+", options: .CaseInsensitive)
        } catch {
            // handle error
        }
        
        // 比較
        let match = regex.matchesInString(yomiageStr, options: .ReportProgress, range:NSMakeRange(0, yomiageStr.characters.count))
        print("matchRange = %d", match.count)
        print("string.length = %d", string.characters.count)
        
        if match.count > 0 {
            // マッチした時の処理
            print("日本語あり")
            language = "ja-JP";
            
            let matchRange = match.count // マッチした個数
            //マッチした個数と文字列の長さが同じ場合(全て日本語)
            if matchRange == string.characters.count {
                print("日本語のみ")
                //日本語のみの場合の処理
            }
        } else {
            print("日本語なし")
            language = "en-US"
        }
        
        return language
    }
    
    class func before_iPhone6() -> Bool {
        
        var size: Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](count: size, repeatedValue: 0)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        let deviceName = String.fromCString(machine)! // 例: iPad3,1
        
        return deviceName.hasPrefix("iPhone3,1")
            || deviceName.hasPrefix("iPhone3,2")
            || deviceName.hasPrefix("iPhone3,3")
            || deviceName.hasPrefix("iPhone4,1")
            || deviceName.hasPrefix("iPhone5,")
            || deviceName.hasPrefix("iPhone6,")
    }
    
    class func say_game_over() {
        if useSound {
            yomiage.stopSpeakingAtBoundary(.Immediate)
            let game_over_voice = AVSpeechSynthesizer()
            let utterance = AVSpeechUtterance(string:"GAME..OVER")
            utterance.voice =  AVSpeechSynthesisVoice(language:"en-US")
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate // はやさ
            utterance.pitchMultiplier = 0 // 声のピッチ
            game_over_voice.speakUtterance(utterance)
        }
    }
}
