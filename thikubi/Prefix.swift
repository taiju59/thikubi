//
//  Prefix.swift
//  thikubi
//
//  Created by Taiju Aoki on 2015/10/03.
//  Copyright © 2015年 Taiju Aoki. All rights reserved.
//

import UIKit

/*--------------------------------------------------
定数
--------------------------------------------------*/

let APP_ID: String = "1018869946"
let APPIRATER_APP_NAME: String = "Don't Touch me！"
let APP_STORE_URL: String = "https://appsto.re/jp/6IRU8.i"
let APP_VERSION = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString")

// 何度目の白クリアでレビューを依頼するか
let REVIEW_CLEAR_COUNT: Int = 5

let SCREEN_HEIGHT: CGFloat = UIScreen.mainScreen().bounds.height
let BOMB_RATE: CGFloat = (SCREEN_HEIGHT * 2)/15

/*--------------------------------------------------
スコア / ポイント
--------------------------------------------------*/

// クリアスコア
let EASY_SCORE: Int = 80
let NORMAL_SCORE: Int = 278
let HARD_SCORE: Int = 403

// クリアノルマ
let EASY_NEXT_COUNT: Int = 20
let NORMAL_NEXT_COUNT: Int = 119
let HARD_NEXT_COUNT: Int = 150

// クリアタイム(過ぎればゲームオーバー)
let EASY_NEXT_TIME: Int = 10
let NORMAL_NEXT_TIME: Int = 30
let HARD_NEXT_TIME: Int = 40

// ゲームオーバーまでの回数
let GAME_OVER: Int = 10

// ポイント増減
let EASY_UP: Int = 4
let NORMAL_UP: Int = 2
let HARD_UP: Int = 1

let EASY_DOWN: Int = 10
let NORMAL_DOWN: Int = 20
let HARD_DOWN: Int = 30

let sound_x: CGFloat = 280
let sound_y: CGFloat = 480
let sound_w: CGFloat = 32
let sound_h: CGFloat = 32


/*--------------------------------------------------
設定
--------------------------------------------------*/

// よく使う影のView
let shadowColor: UIColor = UIColor(red:0/255, green:0/255, blue:0/255, alpha:0.7)

// 背景色の選択
let color1: UIColor = UIColor(red: 137/255, green: 212/255, blue:255/255, alpha: 1.0) // 青
let color2: UIColor = UIColor(red: 253/255, green: 176/255, blue:179/255, alpha: 1.0) // 赤
let color3: UIColor = UIColor(red: 255/255, green: 211/255, blue:149/255, alpha: 1.0) // 肌色
let color4: UIColor = UIColor(red: 255/255, green: 255/255, blue:127/255, alpha: 1.0) // 黄
let color5: UIColor = UIColor(red: 191/255, green: 255/255, blue:127/255, alpha: 1.0) // 緑

// デフォルトのセリフ
let DEFAULT_GOOD_VOICE: String = String(localizeKey: Keys.DEFAULT_GOOD_VOICE)
let DEFAULT_GREAT_VOICE: String = String(localizeKey: Keys.DEFAULT_GREAT_VOICE)


/*--------------------------------------------------
デバッグ用
--------------------------------------------------*/

// 常にTクビ
let THIKUBI_ALL: Bool = false

// データセーブ機能ON/OFF
let DATA_SAVE: Bool = false

// 当たり範囲を見えるようにする
let SHOW_CHIKUBI: Bool = false

// UIActivityではなくTwitter共有にする
let useTwitter: Bool = true

// HARDモードの当たり判定をさらに狭める
let EXTRA_HARD: Bool = false

// 音声ON/OFF機能をつける
let SOUND_FUNCTION: Bool = false

/*--------------------------------------------------
achievement用
--------------------------------------------------*/

let sakamoto: Int  = 114
let aoki: Int      = 69
let kobayashi: Int = 34

/*--------------------------------------------------
iconFont
--------------------------------------------------*/

let ICON_TIME: String = "\u{e900}"
let ICON_SHARE: String = "\u{e901}"
let ICON_FUNC: String = "\u{e902}"
let ICON_GC: String = "\u{e903}"
let ICON_NORMAL: String = "\u{e905}"
let ICON_SPEAKER: String = "\u{e906}"
let ICON_MUTE: String = "\u{e907}"
let ICON_TWITTER: String = "\u{e908}"







