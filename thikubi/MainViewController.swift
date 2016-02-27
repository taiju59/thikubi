//
//  MainViewController.swift
//  thikubi
//
//  Created by Taiju Aoki on 2015/10/02.
//  Copyright © 2015年 Taiju Aoki. All rights reserved.
//

import UIKit
import Social
import GameKit
import SceneKit
import iAd

class MainViewController: ViewController, GKGameCenterControllerDelegate, NADViewDelegate {
    
    @IBOutlet weak var nadView: NADView!
    
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var showGameCenterBtn: UIButton!
    
    var startView: UIView = UIView()
    @IBOutlet weak var skinL: UIButton!
    @IBOutlet weak var skinR: UIButton!
    @IBOutlet weak var startThikubiL: UIButton!
    @IBOutlet weak var startThikubiR: UIButton!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var leftRipple: UIView!
    @IBOutlet weak var rightRipple: UIView!
    @IBOutlet weak var startTimeLabel: UIButton!
    private var rippleTimer: NSTimer = NSTimer()
    
    var clearView: UIView!
    @IBOutlet weak var clearTouchCountLabel: UILabel!
    @IBOutlet weak var clearSideLabel: UILabel!
    @IBOutlet weak var clearColorLabel: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var clearNextBtn: FlatButton!
    @IBOutlet weak var resetTostartBtn: FlatButton!
    @IBOutlet weak var clearFadeInLabel: UILabel!
    @IBOutlet weak var resetToStartBottomMargin: NSLayoutConstraint!
    
    var gameOverView: UIView = UIView()
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var giveUpButton: FlatButton!
    @IBOutlet weak var continueButton: FlatButton!
    
    private var timeAttackMode: Bool = false
    private var timer: NSTimer = NSTimer()
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeButton: UIButton!
    private var isTimeStop: Bool = false
    private var timeStopCoverView = UIView()
    private var timeStopLabel: UILabel = UILabel()
    private var timeStopButton: UIButton = UIButton()
    private var clearTime:[Int] = []
    private var isReleasedTimeMode: Bool = false
    @IBOutlet weak var timeModeButton: UIButton!
    @IBOutlet weak var slashButton: UIButton!
    
    
    
    override func loadView() {
        super.loadView()
        super.loadXibView("BaseView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setColor()
        showStartView()
        SystemManager.sharedInstance.modeSetting()
        //        authenticateLocalPlayer()
        if (SHOW_CHIKUBI) {
            chikubiRight.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0.5)
            chikubiLeft.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0.5)
        }
        
        setStopTimeView()
        //        setParticle()
    }
    
    //    private func setParticle() {
    //        let scene: SCNScene = SCNScene()
    //
    //        let cameraNode: SCNNode = SCNNode()
    //        cameraNode.camera = SCNCamera()
    //        scene.rootNode.addChildNode(cameraNode)
    //        cameraNode.position = SCNVector3(x: 0, y: 0, z: 20)
    //
    //        let pyramid: SCNPyramid = SCNPyramid(width: 2.0, height: 2.0, length: 2.0)
    //        pyramid.firstMaterial!.diffuse.contents = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
    //        let pyramidNode: SCNNode = SCNNode()
    //        pyramidNode.geometry = pyramid
    //        pyramidNode.position = SCNVector3(x: 0.0, y: 0, z: 0)
    //        scene.rootNode.addChildNode(pyramidNode)
    //        pyramidNode.runAction(SCNAction.repeatActionForever(
    //            SCNAction.rotateByX(0.1, y: 0.2, z: 0.0, duration: 2.0)
    //            ))
    //
    //        //パーティクルシステムのオブジェクト生成、およびノードへの追加
    //        let confetti: SCNParticleSystem = SCNParticleSystem(named: "confetti.scnp", inDirectory: "")!
    //        pyramidNode.addParticleSystem(confetti)
    //
    //        let scnView: SCNView? = self.view as? SCNView
    //        scnView?.scene = scene
    //        scnView?.allowsCameraControl = true
    //        scnView?.autoenablesDefaultLighting = true
    //        scnView?.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.8, alpha: 1.0)
    //    }
    //
    //    override func shouldAutorotate() -> Bool {
    //        return true
    //    }
    //
    //    override func prefersStatusBarHidden() -> Bool {
    //        return true
    //    }
    //
    //    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    //        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
    //            return UIInterfaceOrientationMask.AllButUpsideDown
    //        } else {
    //            return UIInterfaceOrientationMask.All
    //        }
    //    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
        timeLabel.hidden = !timeAttackMode
        timeButton.hidden = !timeAttackMode
    }
    
    func setStopTimeView() {
        
        timeStopCoverView = UIView(frame: self.view.frame)
        timeStopCoverView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        timeStopLabel.frame = timeLabel.frame
        timeStopLabel.center = CGPointMake(self.view.center.x, timeLabel.center.y)
        timeStopLabel.font = timeLabel.font
        timeStopLabel.textColor = UIColor.whiteColor()
        timeStopLabel.text = "00:00"
        timeStopButton.frame = timeStopLabel.frame
        timeStopButton.addTarget(self, action: Selector("didTapTimeButton:"), forControlEvents: .TouchUpInside)
        timeStopCoverView.alpha = 0.0
        self.view.addSubview(timeStopCoverView)
        timeStopCoverView.addSubview(timeStopLabel)
        timeStopCoverView.addSubview(timeStopButton)
    }
    
    private func loadData() {
        
        var color: UIColor = UIColor()
        if let selectedColor: Int = userDefaults.integerForKey(Keys.COLOR_NUM) {
            choiceColorNum = selectedColor
            switch choiceColorNum {
            case 1:
                color = color1
                break
            case 2:
                color = color2
                break
            case 3:
                color = color3
                break
            case 4:
                color = color4
                break
            case 5:
                color = color5
                break
            default:
                color = color1
                choiceColorNum = 1
                userDefaults.setInteger(choiceColorNum, forKey: Keys.COLOR_NUM)
                break
            }
        }
        
        //        self.startView.backgroundColor = color //
        self.view.backgroundColor = color
        
        if let v1: String = userDefaults.stringForKey(Keys.VOICE1) {
            voice1 = v1
        }
        if let v2: String = userDefaults.stringForKey(Keys.VOICE2) {
            voice2 = v2
        }
        
        isReleasedTimeMode = userDefaults.boolForKey(Keys.RELEASE_TIME_MODE)
        
        useSound = userDefaults.boolForKey(Keys.USE_SOUND)
        
    }
    
    private func setColor() {
        let score = SystemManager.sharedInstance.score
        chikubiLeft.backgroundColor = Utils.scoreToColor(score)
        chikubiRight.backgroundColor = Utils.scoreToColor(score)
        print("score = \(score)")
    }
    
    // MARK: - Touched
    override func somethingTouched(sender: UIButton) {
        super.somethingTouched(sender)
        
        SystemManager.sharedInstance.touchCount += 1
        setColor()
        if SystemManager.sharedInstance.clearCheck() {
            didClear()
        }
    }
    
    override func chikubiTapped() {
        super.chikubiTapped()
        // クリア値を超えないようにする
        SystemManager.sharedInstance.touched(.Chikubi)
        let point = SystemManager.sharedInstance.up * (2 + SystemManager.sharedInstance.combo)
        showPoint(SystemManager.sharedInstance.nowMode, route:.Chikubi, point:point)
        SystemManager.sharedInstance.combo += 1
        
        
        var ripple: [UIView] = [UIView(frame: self.chikubiLeft.frame), UIView(frame: self.chikubiRight.frame)]
        ripple = ripple.map({
            $0.layer.cornerRadius = $0.frame.width/2
            $0.backgroundColor = self.chikubiLeft.backgroundColor
            self.view.insertSubview($0, atIndex: 0)
            return $0
        })
        UIView.animateWithDuration(
            0.5,
            delay: 0,
            options: .CurveEaseIn,
            animations: {() -> Void in
                ripple[0].transform = CGAffineTransformMakeScale(BOMB_RATE, BOMB_RATE)
                ripple[1].transform = CGAffineTransformMakeScale(BOMB_RATE, BOMB_RATE)
                ripple[0].alpha = 0
                ripple[1].alpha = 0
            },
            completion: {(completion) -> Void in
                ripple[0].removeFromSuperview()
                ripple[1].removeFromSuperview()
        })
    }
    
    override func aroundTapped() {
        super.aroundTapped()
        SystemManager.sharedInstance.touched(.Around)
        showPoint(SystemManager.sharedInstance.nowMode, route:.Around, point:SystemManager.sharedInstance.up)
    }
    
    override func touchExceptChikubi() {
        super.touchExceptChikubi()
        SystemManager.sharedInstance.touched(.Outside)
        
        let mode = SystemManager.sharedInstance.nowMode
        let score = SystemManager.sharedInstance.score
        let down = SystemManager.sharedInstance.down
        if mode == .Easy && (score - down) <= 0 {
            showPoint(mode, route:.Outside ,point:(score - 0))
            SystemManager.sharedInstance.score = 0
            SystemManager.sharedInstance.under_combo++
        } else if mode == .Normal && (score - down) <= EASY_SCORE {
            showPoint(mode, route:.Outside ,point:(score - EASY_SCORE))
            SystemManager.sharedInstance.score = EASY_SCORE
            SystemManager.sharedInstance.under_combo++
        } else if mode == .Hard && (score - down) <= NORMAL_SCORE {
            showPoint(mode, route:.Outside, point:(score - NORMAL_SCORE))
            SystemManager.sharedInstance.score = NORMAL_SCORE
            SystemManager.sharedInstance.under_combo++
        } else {
            showPoint(mode, route:.Outside, point:down)
            SystemManager.sharedInstance.score -= down
        }
        
        if !timeAttackMode && SystemManager.sharedInstance.under_combo >= GAME_OVER {
            game_over()
        }
    }
    
    private func showPoint(mode: Mode, route: TouchType, point: Int) {
        let pointLabel = Utils.getPointLabel(mode, route: route, point: point)
        pointLabel.center = CGPointMake(self.view.center.x, self.view.center.y + 10)
        self.view.addSubview(pointLabel)
        
        UIView.animateWithDuration(
            0.5,
            animations: {() -> Void in
                pointLabel.hidden = false
                switch route {
                case .Chikubi, .Around:
                    pointLabel.transform = CGAffineTransformMakeTranslation(0, -10)
                case .Outside:
                    pointLabel.transform = CGAffineTransformMakeTranslation(0, +10)
                }
                pointLabel.alpha = 0.0
            }) { (Bool) -> Void in
                pointLabel.removeFromSuperview()
        }
    }
    
    //MARK: - START VIEW
    private func showStartView() {
        
        //        let key = Keys.START_LABEL
        //        let localizeStr = String(localizeKey: key)
        //        startButton.setTitle(localizeStr, forState: .Normal)
        
        startView = UINib(nibName: "StartView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        startView.frame = self.view.frame
        startView.alpha = 0.0
        self.view.addSubview(startView)
        
        // 爆発用色
        skinL.layer.cornerRadius = skinL.frame.width/2
        skinR.layer.cornerRadius = skinR.frame.width/2
        
        settingButton.setTitle(ICON_FUNC, forState: .Normal)
        showGameCenterBtn.setTitle(ICON_GC, forState: .Normal)
        if timeAttackMode {
            timeModeButton?.setTitle(ICON_TIME, forState: .Normal)
        } else {
            timeModeButton?.setTitle(ICON_NORMAL, forState: .Normal)
        }
        
        // タイムアタックモードボタン
        let releaseTimeMode = userDefaults.boolForKey(Keys.RELEASE_TIME_MODE)
        timeModeButton.enabled = releaseTimeMode
        slashButton.hidden = releaseTimeMode
        startTimeLabel?.hidden = !timeAttackMode
        
        UIView.animateWithDuration(
            0.7,
            delay:0,
            options:.CurveEaseInOut,
            animations: {() -> Void in
                self.startView.alpha = 1.0
                self.chikubiLeft.alpha = 0.0
                self.chikubiRight.alpha = 0.0
            }) { (Bool) -> Void in
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * Int64(NSEC_PER_SEC)), dispatch_get_main_queue(), {
                    self.startRipple()
                    self.rippleTimer.invalidate()
                    self.rippleTimer = NSTimer.scheduledTimerWithTimeInterval(2.5, target:self, selector: Selector("startRipple"), userInfo: nil, repeats: true)
                });
        }
        
        nadView.delegate = self
    }
    
    func startRipple() {
        let random = Int(arc4random() % 5)
        var rippleColor: UIColor = UIColor()
        if random == choiceColorNum - 1 {
            rippleColor = UIColor.whiteColor()
        } else {
            switch random {
            case 0:
                rippleColor = color1//.colorWithAlphaComponent(0.3)
            case 1:
                rippleColor = color2//.colorWithAlphaComponent(0.3)
            case 2:
                rippleColor = color3//.colorWithAlphaComponent(0.3)
            case 3:
                rippleColor = color4//.colorWithAlphaComponent(0.3)
            case 4:
                rippleColor = color5//.colorWithAlphaComponent(0.3)
            default: break
            }
        }
        
        leftRipple.backgroundColor = rippleColor
        rightRipple.backgroundColor = rippleColor
        leftRipple.transform = CGAffineTransformIdentity
        rightRipple.transform = CGAffineTransformIdentity
        leftRipple.alpha = 1
        rightRipple.alpha = 1
        UIView.animateWithDuration(
            0.5,
            delay: 0,
            options: .CurveEaseIn,
            animations: {() -> Void in
                self.startThikubiL.transform = CGAffineTransformMakeScale(0.5, 0.5)
                self.startThikubiR.transform = CGAffineTransformMakeScale(0.5, 0.5)
                self.leftRipple.transform = CGAffineTransformMakeScale(0.5, 0.5)
                self.rightRipple.transform = CGAffineTransformMakeScale(0.5, 0.5)
            }) { (Bool) -> Void in
                UIView.animateWithDuration(
                    0.25,
                    delay: 0,
                    options: .CurveEaseIn,
                    animations: {() -> Void in
                        self.startThikubiL.transform = CGAffineTransformMakeScale(2, 2)
                        self.startThikubiR.transform = CGAffineTransformMakeScale(2, 2)
                    }) { (Bool) -> Void in
                        UIView.animateWithDuration(
                            0.25,
                            delay: 0,
                            options: .CurveEaseIn,
                            animations: { () -> Void in
                                self.startThikubiL.transform = CGAffineTransformMakeScale(0.8, 0.8)
                                self.startThikubiR.transform = CGAffineTransformMakeScale(0.8, 0.8)
                            }) { (Bool) -> Void in
                                UIView.animateWithDuration(
                                    0.3,
                                    delay: 0,
                                    options: .CurveEaseIn,
                                    animations: { () -> Void in
                                        self.startThikubiL.transform = CGAffineTransformIdentity
                                        self.startThikubiR.transform = CGAffineTransformIdentity
                                    }, completion: nil)
                        }
                }
        }
        UIView.animateWithDuration(
            2,
            delay: 0.5,
            options: .CurveEaseOut,
            animations: {() -> Void in
                self.leftRipple.transform = CGAffineTransformMakeScale(BOMB_RATE/3, BOMB_RATE/3)
                self.rightRipple.transform = CGAffineTransformMakeScale(BOMB_RATE/3, BOMB_RATE/3)
                self.leftRipple.alpha = 0
                self.rightRipple.alpha = 0
            }, completion:nil
        )
    }
    
    // スタート画面を閉じる
    @IBAction func closeStartView() {
        
        rippleTimer.invalidate()
        startLabel?.removeFromSuperview() // 消えるのが遅いため先にremove
        settingButton?.removeFromSuperview() // 消えるのが遅いため先にremove
        showGameCenterBtn?.removeFromSuperview() // 消えるのが遅いため先にremove
        timeModeButton?.removeFromSuperview() // 消えるのが遅いため先にremove
        slashButton?.removeFromSuperview() // 消えるのが遅いため先にremove
        
        self.skinL.backgroundColor = self.view.backgroundColor
        self.skinR.backgroundColor = self.view.backgroundColor
        
        startView.layer.removeAllAnimations()
        self.view.layer.removeAllAnimations()
        
        // 肌色爆発
        UIView.animateWithDuration(
            0.3,
            animations: {() -> Void in
                self.chikubiLeft.alpha = 1.0
                self.chikubiRight.alpha = 1.0
                
                self.skinL.transform = CGAffineTransformMakeScale(BOMB_RATE, BOMB_RATE)
                self.skinR.transform = CGAffineTransformMakeScale(BOMB_RATE, BOMB_RATE)
                self.startView.alpha = 0
            }) { (Bool) -> Void in
                VoiceManager.voice(voice1)
                self.startView.removeFromSuperview()
                self.timerStart()
        }
    }
    
    @IBAction func toSetting(sender: UIButton) {
        VoiceManager.voice(voice1)
        self.performSegueWithIdentifier("toSetting", sender:self)
    }
    
    //MARK: - CLEAR
    // モードクリア処理
    private func didClear() {
        
        timer.invalidate()
        
        let clearedMode: Mode = SystemManager.sharedInstance.nowMode
        var showNext: Bool = false
        
        SystemManager.sharedInstance.clearTouchCount = SystemManager.sharedInstance.touchCount
        clearTime = [second, sSecond]
        chikubiBomb()
        
        // 「次へ進む」を押さなくてもモードを進める
        if SystemManager.sharedInstance.nowMode == .Easy &&  (SystemManager.sharedInstance.touchCount <= EASY_NEXT_COUNT || timeAttackMode) {
            showNext = true
            // ゲームセンターへ通知
            if !timeAttackMode {
                submitScore(SystemManager.sharedInstance.clearTouchCount, forCategory:"thikubi_easy")
                reportAchievementIdentifier("first_brown", percentComplete:100)
                if SystemManager.sharedInstance.touchCount <= 5 {
                    reportAchievementIdentifier("brown_5", percentComplete:100)
                }
            }
            SystemManager.sharedInstance.nowMode = .Normal
            SystemManager.sharedInstance.score = EASY_SCORE
            SystemManager.sharedInstance.under_combo -= 5
        } else if SystemManager.sharedInstance.nowMode == .Normal &&  (SystemManager.sharedInstance.touchCount <= NORMAL_NEXT_COUNT || timeAttackMode) {
            showNext = true
            // ゲームセンターへ通知
            if !timeAttackMode {
                submitScore(SystemManager.sharedInstance.clearTouchCount, forCategory:"thikubi_pink")
                reportAchievementIdentifier("first_pink", percentComplete:100)
            }
            SystemManager.sharedInstance.nowMode = .Hard
            SystemManager.sharedInstance.score = NORMAL_SCORE
            SystemManager.sharedInstance.under_combo -= 5
        } else if SystemManager.sharedInstance.nowMode == .Hard &&  (SystemManager.sharedInstance.touchCount <= HARD_NEXT_COUNT || timeAttackMode) {
            showNext = true
            // ゲームセンターへ通知
            if !timeAttackMode {
                submitScore(SystemManager.sharedInstance.clearTouchCount, forCategory:"thikubi_white")
                reportAchievementIdentifier("first_white", percentComplete:100)
                if SystemManager.sharedInstance.clearTouchCount <= 200 {
                    reportAchievementIdentifier("white_200", percentComplete:100)
                }
                if SystemManager.sharedInstance.clearTouchCount < sakamoto {
                    reportAchievementIdentifier("white_150", percentComplete:100)
                }
                if SystemManager.sharedInstance.clearTouchCount < aoki {
                    reportAchievementIdentifier("white_100", percentComplete:100)
                }
                if SystemManager.sharedInstance.clearTouchCount < kobayashi {
                    reportAchievementIdentifier("kobayashi", percentComplete:100)
                }
            }
            SystemManager.sharedInstance.nowMode = .Easy
            SystemManager.sharedInstance.score = 0
            SystemManager.sharedInstance.combo = 0
            SystemManager.sharedInstance.touchCount = 0
            SystemManager.sharedInstance.under_combo = 0
            timerReset()
            // レビュー(bombアニメーションと被るため遅延実行)
            let clear3Count: Int = userDefaults.integerForKey(Keys.CLEAR_3_COUNT) % REVIEW_CLEAR_COUNT + 1
            if clear3Count == REVIEW_CLEAR_COUNT && !userDefaults.boolForKey(Keys.REVIEWED) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * Int64(NSEC_PER_SEC)), dispatch_get_main_queue(), {
                    self.showReview()
                });
            }
            userDefaults.setInteger(clear3Count, forKey: Keys.CLEAR_3_COUNT)
            userDefaults.synchronize()
            // ----------------------------------------
        } else { // クリアはしたが規定回数を上回ってしまった場合
            showNext = false
            // ゲームセンターへ通知
            if SystemManager.sharedInstance.nowMode == .Easy {
                submitScore(SystemManager.sharedInstance.clearTouchCount, forCategory:"thikubi_easy")
                reportAchievementIdentifier("first_brown", percentComplete:100)
                if SystemManager.sharedInstance.touchCount <= 5 {
                    reportAchievementIdentifier("brown_5", percentComplete:100)
                }
            } else if SystemManager.sharedInstance.nowMode == .Normal {
                submitScore(SystemManager.sharedInstance.clearTouchCount, forCategory:"thikubi_pink")
                reportAchievementIdentifier("first_pink", percentComplete:100)
            } else if SystemManager.sharedInstance.nowMode == .Hard {
                submitScore(SystemManager.sharedInstance.clearTouchCount, forCategory:"thikubi_white")
                reportAchievementIdentifier("first_white", percentComplete:100)
                if SystemManager.sharedInstance.clearTouchCount <= 200 {
                    reportAchievementIdentifier("white_200", percentComplete:100)
                }
                if SystemManager.sharedInstance.clearTouchCount < sakamoto {
                    reportAchievementIdentifier("white_150", percentComplete:100)
                }
                if SystemManager.sharedInstance.clearTouchCount < aoki {
                    reportAchievementIdentifier("white_100", percentComplete:100)
                }
                if SystemManager.sharedInstance.clearTouchCount < kobayashi {
                    reportAchievementIdentifier("kobayashi", percentComplete:100)
                }
            }
            SystemManager.sharedInstance.nowMode = .Easy
            SystemManager.sharedInstance.score = 0
            SystemManager.sharedInstance.combo = 0
            SystemManager.sharedInstance.touchCount = 0
            SystemManager.sharedInstance.under_combo = 0
            timerReset()
        }
        
        showClearVIew(clearedMode, showNext: showNext)
    }
    
    // モードクリア時画面
    private func showClearVIew(clearedMode: Mode, showNext: Bool) {
        
        SystemManager.sharedInstance.clearedModeForPost = clearedMode //ポスト用にクリアモード保持
        
        // Viewを覆う影になるView
        clearView = UINib(nibName: "ClearView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        clearView.frame = self.view.frame
        clearView.alpha = 0.0
        self.view.addSubview(clearView)
        
        let (font_color, color_str) = SystemManager.getClearColor(clearedMode)
        
        // 回数ラベル
        if timeAttackMode {
            clearTouchCountLabel.text = String(format: "%d.%02d", clearTime[0], clearTime[1])
        } else {
            clearTouchCountLabel.text = String(SystemManager.sharedInstance.clearTouchCount)
        }
        clearTouchCountLabel.textColor = font_color
        
        // 回数横ラベル
        clearSideLabel.text = timeAttackMode ? String(localizeKey: Keys.CLEAR_SIDE_LABEL_SECOND):String(localizeKey: Keys.CLEAR_SIDE_LABEL_TOUCH)
        clearSideLabel.textColor = font_color
        
        // 色ラベル
        clearColorLabel.text = String(localizeKey: Keys.CLEAR_COLOR_LABEL, color_str)
        clearColorLabel.textColor = font_color
        
        // 次へ進む
        clearNextBtn.hidden = (SystemManager.sharedInstance.nowMode == .Easy) ? true:false
        clearNextBtn.borderColor = font_color
        clearNextBtn.cornerRadius = clearNextBtn.frame.height/8 //なんとなく
        clearNextBtn.setTitleColor(font_color, forState: .Normal)
        clearNextBtn.setTitleColor(chikubiLeft.backgroundColor, forState: .Highlighted)
        clearNextBtn.alpha = 0
        
        // はじめから
        resetTostartBtn.borderColor = font_color
        resetTostartBtn.cornerRadius = resetTostartBtn.frame.height/8 //なんとなく
        resetTostartBtn.setTitleColor(font_color, forState: .Normal)
        resetTostartBtn.setTitleColor(chikubiLeft.backgroundColor, forState: .Highlighted)
        resetTostartBtn.alpha = 0
        if clearNextBtn.hidden {
            resetToStartBottomMargin.constant += 50
        }
        
        // ボタン
        settingButton.setTitle(ICON_FUNC, forState: .Normal)
        settingButton.setTitleColor(font_color, forState: .Normal)
        
        showGameCenterBtn.setTitle(ICON_GC, forState: .Normal)
        showGameCenterBtn.setTitleColor(font_color, forState: .Normal)
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            shareBtn.setTitle(ICON_TWITTER, forState: .Normal)
        } else {
            shareBtn.setTitle(ICON_SHARE, forState: .Normal)
        }
        shareBtn.setTitleColor(font_color, forState: .Normal)
        
        //  フェードインラベル
        clearFadeInLabel.text = ""
        if !timeAttackMode && !showNext {
            if clearedMode == .Easy {
                clearFadeInLabel.text = String(localizeKey: Keys.CLEAR_FADE_IN_LABEL1, EASY_NEXT_COUNT)
            } else if clearedMode == .Normal {
                clearFadeInLabel.text = String(localizeKey: Keys.CLEAR_FADE_IN_LABEL1, NORMAL_NEXT_COUNT)
            } else if clearedMode == .Hard && !isReleasedTimeMode {
                clearFadeInLabel.text = String(localizeKey: Keys.CLEAR_FADE_IN_LABEL2, HARD_NEXT_COUNT)
            }
        } else if clearedMode == .Hard && !isReleasedTimeMode && showNext {
            clearFadeInLabel.text = String(localizeKey: Keys.TIME_MODE_RELEASE_ALERT_TITLE)
            releaseTimeAttackMode()
        }
        clearFadeInLabel.textColor = font_color
        
        appearClearView()
    }
    
    private func appearClearView() {
        // フェードイン
        self.view.sendSubviewToBack(timeLabel)
        clearFadeInLabel.transform = CGAffineTransformMakeTranslation( -clearFadeInLabel.frame.origin.x - clearFadeInLabel.frame.width, 0)
        UIView.animateWithDuration(
            2.0,
            delay:0,
            options:.CurveEaseInOut,
            animations: {() -> Void in
                self.clearView.alpha = 1.0
                self.clearFadeInLabel.transform = CGAffineTransformMakeTranslation(10, 0)
            }) { (Bool) -> Void in
                UIView.animateWithDuration(
                    0.5,
                    delay:0,
                    options:.CurveEaseInOut,
                    animations: {() -> Void in
                        self.clearFadeInLabel.transform = CGAffineTransformIdentity
                    },
                    completion: nil
                )
        }
        UIView.animateWithDuration(
            0.2,
            delay:0.3,
            options:.CurveEaseInOut,
            animations: {() -> Void in
                self.clearNextBtn.alpha = 1.0
                self.resetTostartBtn.alpha = 1.0
            },
            completion: nil
        )
    }
    
    // 次のモードへ（モードは既に進んでいてここはそれを画面に反映させるだけ）
    @IBAction func nextMode() {
        removeClearView()
    }
    
    @IBAction func resetToStart() {
        SystemManager.sharedInstance.modeReset()
        timerReset()
        removeClearView()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if userDefaults.boolForKey(Keys.RELEASE_TIME_MODE) && !userDefaults.boolForKey(Keys.FINISH_TIME_TUTORIAL) {
            self.performSegueWithIdentifier("toTutorial", sender: nil)
            
            // 説明中終了した場合変なタイミングで説明が入るため 表示 = 説明完了 と捉える
            userDefaults.setBool(true, forKey: Keys.FINISH_TIME_TUTORIAL)
            userDefaults.synchronize()
        }
    }
    
    private func removeClearView() {
        VoiceManager.voice(voice1)
        updateTimeLabel()
        setColor()
        SystemManager.sharedInstance.modeSetting()
        if SystemManager.sharedInstance.nowMode == .Easy {
            backToStartView(clearView)
            chikubiReturn(true)
        } else {
            clearView.removeFromSuperview()
            chikubiReturn(false)
        }
    }
    
    // 乳首拡大
    private func chikubiBomb() {
        if SystemManager.sharedInstance.combo == 0 {
            UIView.animateWithDuration(
                0.3,
                delay:0,
                options:.CurveEaseInOut,
                animations: {() -> Void in
                    self.chikubiRight.transform = CGAffineTransformMakeScale(0.3, 0.3)
                    self.chikubiLeft.transform = CGAffineTransformMakeScale(0.3, 0.3)
                }) { (Bool) -> Void in
                    UIView.animateWithDuration(
                        0.2,
                        delay:0,
                        options:.CurveEaseInOut,
                        animations: {() -> Void in
                            self.chikubiRight.transform = CGAffineTransformMakeScale(BOMB_RATE, BOMB_RATE)
                            self.chikubiLeft.transform = CGAffineTransformMakeScale(BOMB_RATE, BOMB_RATE)
                        },
                        completion: nil
                    )
            }
        } else {
            // 「tくび」のアニメーションと被るため遅延実行
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                UIView.animateWithDuration(
                    0.2,
                    delay:0,
                    options:.CurveEaseInOut,
                    animations: {() -> Void in
                        self.chikubiRight.transform = CGAffineTransformMakeScale(BOMB_RATE, BOMB_RATE)
                        self.chikubiLeft.transform = CGAffineTransformMakeScale(BOMB_RATE, BOMB_RATE)
                    },
                    completion: nil
                )
            }
        }
    }
    
    // 乳首元に戻る
    private func chikubiReturn(reatarFlug: Bool) {
        UIView.animateWithDuration(
            0.2,
            delay:0.0,
            options: .CurveLinear,
            animations: {() -> Void in
                self.chikubiRight.transform = CGAffineTransformMakeScale(0.05, 0.05)
                self.chikubiLeft.transform = CGAffineTransformMakeScale(0.05, 0.05)
            }) { (Bool) -> Void in
                UIView.animateWithDuration(
                    0.3,
                    delay:0.0,
                    options:.CurveLinear,
                    animations: {() -> Void in
                        self.chikubiRight.transform = CGAffineTransformIdentity
                        self.chikubiLeft.transform = CGAffineTransformIdentity
                    }) { (Bool) -> Void in
                        reatarFlug ? self.timerReset():self.timerStart()
                }
        }
    }
    
    //MARK: - SHARE
    @IBAction func share(sender: UIButton) {
        let clearedMode = SystemManager.sharedInstance.clearedModeForPost
        let (_, colorStr) = SystemManager.getClearColor(clearedMode)
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            postToTwitter(colorStr)
        } else {
            postToOther(colorStr)
        }
    }
    
    // Twitter連携
    private func postToTwitter(strColor: String) {
        VoiceManager.voice(voice1)
        // スクショ
        let rect: CGRect = self.view.bounds
        UIGraphicsBeginImageContextWithOptions(CGSize(width: rect.width, height: rect.height/2), false, 0.0)
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        self.view.layer.renderInContext(context)
        let capturedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // twitterに投稿
        let tweetSheet: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        let text1: String = clearTouchCountLabel.text!
        let text2: String = clearSideLabel.text!
        tweetSheet.setInitialText(String(localizeKey: Keys.SHARE_MSG, text1, text2, String(localizeKey: Keys.CLEAR_COLOR_LABEL, strColor)))
        tweetSheet.addImage(capturedImage)
        tweetSheet.addURL(NSURL(string: APP_STORE_URL))
        self.presentViewController(tweetSheet, animated:true, completion:nil)
    }
    
    // 他に投稿
    private func postToOther(strColor: String) {
        VoiceManager.voice(voice1)
        
        //共有したい物を用意 (Arrayにまとめる)
        let text1: String = clearTouchCountLabel.text!
        let text2: String = clearSideLabel.text!
        let text: String = String(localizeKey: Keys.SHARE_MSG, text1, text2, String(localizeKey: Keys.CLEAR_COLOR_LABEL, strColor))
        let url: String = APP_STORE_URL
        let array: [String] = [text, url]
        
        //アクティビティビューコントローラー
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: array, applicationActivities:[])
        
        // 機能ボタン表示を無効にする
        let excludedActivityTypes: [String]? = [UIActivityTypeAirDrop]
        activityVC.excludedActivityTypes = excludedActivityTypes
        
        self.presentViewController(activityVC, animated:true, completion:nil)
    }
    
    //MARK: - GAME OVER
    // ゲームオーバー画面
    private func game_over() {
        timer.invalidate()
        VoiceManager.say_game_over()
        
        gameOverView = UINib(nibName: "GameOverView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        gameOverView.frame = self.view.frame
        gameOverView.alpha = 0.0
        
        giveUpButton.borderColor = UIColor.whiteColor()
        giveUpButton.cornerRadius = giveUpButton.frame.height/8 //なんとなく
        giveUpButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        giveUpButton.setTitleColor(gameOverView.backgroundColor, forState: .Highlighted)
        
        continueButton.hidden = timeAttackMode
        continueButton.borderColor = UIColor.whiteColor()
        continueButton.cornerRadius = continueButton.frame.height/8 //なんとなく
        continueButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        continueButton.setTitleColor(gameOverView.backgroundColor, forState: .Highlighted)
        
        let mode = SystemManager.sharedInstance.nowMode
        gameOverLabel.text = Utils.getGameOverStr(mode)
        
        settingButton.setTitle(ICON_FUNC, forState: .Normal)
        showGameCenterBtn.setTitle(ICON_GC, forState: .Normal)
        
        self.view.addSubview(gameOverView)
        
        // View出現 & 煽りラベル移動
        self.gameOverLabel.transform = CGAffineTransformMakeTranslation( -gameOverLabel.frame.origin.x - gameOverLabel.frame.width, 0)
        UIView.animateWithDuration(
            1.0,
            animations: {() -> Void in
                self.gameOverLabel.transform = CGAffineTransformIdentity
                self.gameOverLabel.transform = CGAffineTransformMakeTranslation(15, 0)
                self.gameOverView.alpha = 1.0
            }) { (Bool) -> Void in
                UIView.animateWithDuration(
                    0.5,
                    animations: {() -> Void in
                        self.gameOverLabel.transform = CGAffineTransformIdentity
                        self.giveUpButton.backgroundColor = self.gameOverView.backgroundColor
                        self.continueButton.backgroundColor = self.gameOverView.backgroundColor
                    },
                    completion: nil
                )
        }
        
        //        self.canDisplayBannerAds = true // MARK: iAD
    }
    
    
    @IBAction func give_up() {
        SystemManager.sharedInstance.modeReset()
        setColor()
        SystemManager.sharedInstance.modeSetting()
        timerReset()
        backToStartView(gameOverView)
        VoiceManager.voice(voice1)
    }
    
    @IBAction func to_continue() {
        SystemManager.sharedInstance.under_combo = 0
        // MARK: iAD
        self.interstitialPresentationPolicy = .Manual
        self.requestInterstitialAdPresentation()
        gameOverView.removeFromSuperview()
        chikubiReturn(false)
        VoiceManager.voice(voice1)
    }
    
    private func backToStartView(sourceView: UIView) {
        //        self.canDisplayBannerAds = false // MARK: iAD
        updateTimeLabel()
        UIView.animateWithDuration(
            0.7,
            animations: {() -> Void in
                self.showStartView()
                sourceView.alpha = 0
            }) { (Bool) -> Void in
                sourceView.removeFromSuperview()
        }
    }
    
    //MARK: - TIMER
    private func releaseTimeAttackMode() {
        // TODO: タイムアタックモードを解放する
        isReleasedTimeMode = true
        userDefaults.setBool(true, forKey: Keys.RELEASE_TIME_MODE)
        userDefaults.synchronize()
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 6/10 * Int64(NSEC_PER_SEC)), dispatch_get_main_queue(), {
//            let alertController: UIAlertController = UIAlertController(title:String(localizeKey: Keys.TIME_MODE_RELEASE_ALERT_TITLE), message:String(localizeKey: Keys.TIME_MODE_RELEASE_ALERT_MSG), preferredStyle: .Alert)
//            let cancelAction: UIAlertAction = UIAlertAction(title:"OK", style:.Default, handler: nil)
//            alertController.addAction(cancelAction)
//            self.presentViewController(alertController, animated:true, completion:nil)
//        })
    }
    
    @IBAction func switchTimeAttackMode() {
        timeAttackMode = !timeAttackMode
        
        timeLabel.hidden = !timeAttackMode
        timeButton.hidden = !timeAttackMode
        startTimeLabel?.hidden = !timeAttackMode
        if timeAttackMode {
            timeModeButton?.setTitle(ICON_TIME, forState: .Normal)
        } else {
            timeModeButton?.setTitle(ICON_NORMAL, forState: .Normal)
        }
        VoiceManager.voice(voice1)
    }
    
    private func timerStart() {
        if !timer.valid && timeAttackMode {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector: Selector("timeCountUp"), userInfo: nil, repeats: true)
        }
    }
    
    func timeCountUp() {
        sSecond++
        if 100 <= sSecond {
            second += sSecond / 100
            sSecond = sSecond % 100
        }
        
        if SystemManager.sharedInstance.isTimeUp(second) {
            game_over()
        }
        
        updateTimeLabel()
    }
    
    private func timerReset() {
        sSecond = 0
        second = 0
    }
    
    private func updateTimeLabel() {
        let timeStr = String(format: "%02d:%02d", second, sSecond)
        timeLabel.text = timeStr
    }
    
    @IBAction func didTapTimeButton(sender: AnyObject) {
        if isTimeStop == false {
            isTimeStop = true
            timer.invalidate()
            timeLabel.alpha = 0.0 // 座標に誤差が出るため透過
            timeStopCoverView.alpha = 1.0
            timeStopLabel.text = timeLabel.text
        } else {
            timeStopCoverView.alpha = 0.0
            timeLabel.alpha = 1.0 // 座標に誤差が出るための透過を解除
            timerStart()
            isTimeStop = false
        }
    }
    
    //MARK: - GAME CENTER
    /*
    GameCenterにログインしていない場合はアラートを表示、
    ログインしている場合は何もしない。
    */
    //    private func authenticateLocalPlayer() {
    //
    //        //gamecenterのプレイヤーを取得
    //        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
    //        localPlayer.authenticateHandler = {(viewController, error) -> Void in
    //            if viewController != nil // ログインしてなかったらログインを促す
    //            {
    //                let alertController: UIAlertController = UIAlertController(title: String(localizeKey:Keys.GAME_CENTER_ALERT_TITLE), message:String(localizeKey:Keys.GAME_CENTER_ALERT_MSG), preferredStyle: .Alert)
    //                // addActionした順に左から右にボタンが配置されます
    //                let otherAction: UIAlertAction = UIAlertAction(title:String(localizeKey:Keys.GAME_CENTER_ALERT_OK), style:.Default) {
    //                    action in
    //                    // otherボタンが押された時の処理
    //                    let url: NSURL = NSURL(string:"gamecenter:")! // GameCenterアプリに飛ばす
    //                    UIApplication.sharedApplication().openURL(url)
    //                }
    //                let cancelAction: UIAlertAction = UIAlertAction(title:String(localizeKey:Keys.GAME_CENTER_ALERT_NO), style:.Default, handler: nil)
    //                alertController.addAction(otherAction)
    //                alertController.addAction(cancelAction)
    //                self.presentViewController(alertController, animated:true, completion:nil)
    //            } else {
    //                print("error = \(error)")
    //            }
    //        }
    //    }
    
    
    // ストーリボード表示
    @IBAction func GamecenterInit() {
        VoiceManager.voice(voice1)
        let leaderboardController: GKGameCenterViewController = GKGameCenterViewController()
        leaderboardController.gameCenterDelegate = self
        leaderboardController.viewState = .Leaderboards
        self.presentViewController(leaderboardController, animated:true, completion:nil)
    }
    
    // ストーリボードを閉じる際に必要なメソッド
    // GKLeaderboardViewControllerのDelegate
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        VoiceManager.voice(voice1)
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    // スコア送信
    func submitScore(score:Int, forCategory category: String) {
        let scoreReporter: GKScore = GKScore(leaderboardIdentifier:category)
        scoreReporter.value = Int64(SystemManager.sharedInstance.clearTouchCount)
        GKScore.reportScores([scoreReporter], withCompletionHandler:  {
            (error:NSError?) -> Void in
            if error != nil { print("error: \(error)") }
        })
    }
    
    // achievement送信
    func reportAchievementIdentifier(identifier: String, percentComplete percent: Float) {
        
        let achievement: GKAchievement = GKAchievement(identifier:identifier)
        achievement.percentComplete = Double(percent)
        GKAchievement.reportAchievements([achievement], withCompletionHandler:  {
            (error:NSError?) -> Void in
            if error != nil { print("error: \(error)") }
        })
    }
    
    
    //MARK: - REVIEW
    func showReview() {
        let alertController: UIAlertController = UIAlertController(
            title: String(localizeKey: Keys.REVIEW_ALERT_TITLE),
            message: String(localizeKey: Keys.REVIEW_ALERT_MSG),
            preferredStyle: .Alert)
        
        let reviewAction: UIAlertAction = UIAlertAction(title: String(localizeKey: Keys.REVIEW_ALERT_OK), style: .Default) {
            action in
            let url: NSURL = NSURL(string: APP_STORE_URL)!
            UIApplication.sharedApplication().openURL(url)
            userDefaults.setObject(true, forKey: Keys.REVIEWED)
            userDefaults.synchronize()
        }
        let yetAction: UIAlertAction = UIAlertAction(title: String(localizeKey: Keys.REVIEW_ALERT_REMIND_LATER), style: .Default) {
            action in
            userDefaults.setObject(false, forKey: Keys.REVIEWED)
            userDefaults.synchronize()
        }
        let neverAction: UIAlertAction = UIAlertAction(title: String(localizeKey: Keys.REVIEW_ALERT_NO), style: .Cancel) {
            action in
            userDefaults.setObject(true, forKey: Keys.REVIEWED)
            userDefaults.synchronize()
        }
        
        alertController.addAction(reviewAction)
        alertController.addAction(yetAction)
        alertController.addAction(neverAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: - NADVIEW
    //広告ロードが初めて成功した際に通知されます。(任意)
    func nadViewDidFinishLoad(adView: NADView) {
        print("nadViewDidFinishLoad")
    }
    
    
    //広告受信が成功した際に通知されます。(任意)
    func nadViewDidReceiveAd(adView: NADView) {
        print("nadViewDidReceiveAd")
    }
    
    //広告受信に失敗した際に通知されます。(任意)
    func nadViewDidFailToReceiveAd(adView: NADView) {
        print("nadViewDidFailToReceiveAd")
    }
    
    //広告バナークリック時に通知されます。(任意)
    func nadViewDidClickAd(adView: NADView) {
        print("nadViewDidClickAd")
    }
    
}