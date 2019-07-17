//
//  SettingViewController.swift
//  thikubi
//
//  Created by Taiju Aoki on 2015/10/02.
//  Copyright © 2015年 Taiju Aoki. All rights reserved.
//

import UIKit

class SettingViewController: ViewController, UITextFieldDelegate {

    @IBOutlet weak var inputText1: UITextField!
    @IBOutlet weak var inputText2: UITextField!

    @IBOutlet weak var soundButton1: UIButton!
    @IBOutlet weak var soundButton2: UIButton!

    @IBOutlet weak var closeButton: FlatButton!
    @IBOutlet weak var speakerBtn: UIButton!

    @IBOutlet weak var colorBtn1: UIButton!
    @IBOutlet weak var colorBtn2: UIButton!
    @IBOutlet weak var colorBtn3: UIButton!
    @IBOutlet weak var colorBtn4: UIButton!
    @IBOutlet weak var colorBtn5: UIButton!

    var secretNum: [Int] = []
    let correctNum: [Int] = [2, 1, 2, 2, 4, 5, 3]

    override func loadView() {
        super.loadView()
        super.loadXibView(nibName: "SettingView")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        inputText1.delegate = self
        inputText2.delegate = self

        colorBtn1.layer.borderColor = UIColor.darkGray.cgColor
        colorBtn2.layer.borderColor = UIColor.darkGray.cgColor
        colorBtn3.layer.borderColor = UIColor.darkGray.cgColor
        colorBtn4.layer.borderColor = UIColor.darkGray.cgColor
        colorBtn5.layer.borderColor = UIColor.darkGray.cgColor

        colorBtn1.layer.borderWidth = 0
        colorBtn2.layer.borderWidth = 0
        colorBtn3.layer.borderWidth = 0
        colorBtn4.layer.borderWidth = 0
        colorBtn5.layer.borderWidth = 0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()

        soundButton1.isEnabled = useSound
        soundButton2.isEnabled = useSound
        if useSound {
            soundButton1.alpha = 1.0
            soundButton2.alpha = 1.0
        } else {
            soundButton1.alpha = 0.5
            soundButton2.alpha = 0.5
        }

        let iconName = (useSound) ? ICON_SPEAKER:ICON_MUTE
        speakerBtn.setTitle(iconName, for: .normal)
        speakerBtn.tag = useSound ? 2:5

        /**thikubiモード用**/
        secretNum = []
        /**-------------**/
    }

    func loadSettings() {

        var color = UIColor()
        let selectedColor: Int = userDefaults.integer(forKey: Keys.COLOR_NUM)
        choiceColorNum = selectedColor
        switch choiceColorNum {
        case 1:
            color = color1
            colorBtn1.layer.borderWidth = 2
            break
        case 2:
            color = color2
            colorBtn2.layer.borderWidth = 2
            break
        case 3:
            color = color3
            colorBtn3.layer.borderWidth = 2
            break
        case 4:
            color = color4
            colorBtn4.layer.borderWidth = 2
            break
        case 5:
            color = color5
            colorBtn5.layer.borderWidth = 2
            break
        default:
            color = color1
            break
        }

        self.view.backgroundColor = color
        closeButton.setTitleColor(color, for: .highlighted)

        if let v1 = userDefaults.string(forKey: Keys.VOICE1) {
            voice1 = v1
        } else {
            voice1 = DEFAULT_GOOD_VOICE
        }
        inputText1.text = voice1

        if let v2 = userDefaults.string(forKey: Keys.VOICE2) {
            voice2 = v2
        } else {
            voice2 = DEFAULT_GREAT_VOICE
        }
        inputText2.text = voice2
    }

    // MARK: - Touched
    override func somethingTouched(_ sender: UIButton) {
        super.somethingTouched(sender)
    }

    @IBAction override func chikubiTapped() {
        super.chikubiTapped()
    }


    @IBAction override func aroundTapped() {
        super.aroundTapped()
    }

    override func touchExceptChikubi() {
        super.touchExceptChikubi()
    }

    @IBAction func soundSettings(_ sender: UIButton) {
        useSound = !useSound
        userDefaults.set(useSound, forKey: Keys.USE_SOUND)
        userDefaults.synchronize()
        let iconName = (useSound) ? ICON_SPEAKER:ICON_MUTE
        speakerBtn.setTitle(iconName, for: .normal)
        VoiceManager.voice(yomiageStr: voice1)


        soundButton1.isEnabled = useSound
        soundButton2.isEnabled = useSound
        if useSound {
            soundButton1.alpha = 1.0
            soundButton2.alpha = 1.0
        } else {
            soundButton1.alpha = 0.5
            soundButton2.alpha = 0.5
        }

    }

    // スタート画面へ戻る
    @IBAction internal func toStart(_ sender: UIButton){
        VoiceManager.voice(yomiageStr: voice1)

        userDefaults.set(voice1, forKey: Keys.VOICE1)
        userDefaults.set(voice2, forKey: Keys.VOICE2)
        userDefaults.set(choiceColorNum, forKey: Keys.COLOR_NUM)
        userDefaults.synchronize()

        self.dismiss(animated: true, completion: nil)
    }


    //MARK: KeyBoard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeSKB()
    }

    /**
    * テキストが編集されたとき
    * @param textField イベントが発生したテキストフィールド
    * @param range 文字列が置き換わる範囲(入力された範囲)
    * @param string 置き換わる文字列(入力された文字列)
    * @retval YES 入力を許可する場合
    * @retval NO 許可しない場合
    */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        // すでに入力されているテキストを取得
        let text: NSMutableString = (textField.text?.mutableCopy() as? NSMutableString)!
        // すでに入力されているテキストに今回編集されたテキストをマージ
        text.replaceCharacters(in: range, with:string)
        // 入力中の文字を入れる
        if textField == inputText1 {
            voice1 = text.length == 0 ? DEFAULT_GOOD_VOICE:text as String
        } else if textField == inputText2 {
            voice2 = text.length == 0 ? DEFAULT_GREAT_VOICE:text as String
        }
        // 結果が文字数をオーバーしていないならYES，オーバーしている場合はNO
        return text.length <= 8
    }

        /**
        * キーボードでReturnキー選択時のイベントハンドラ
        * @param textField イベントが発生したテキストフィールド
        */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == inputText1 {
            if inputText1.text?.count == 0 {inputText1.text = DEFAULT_GOOD_VOICE}
            voice1 = inputText1.text!
            inputText2.becomeFirstResponder()
            aroundTapped()

        } else if textField == inputText2 {
            if inputText2.text?.count == 0 {inputText2.text = DEFAULT_GREAT_VOICE}
            voice2 = inputText2.text!
            closeSKB()
            chikubiTapped()
        }
        return true
    }


    // キーボードを閉じる
    func closeSKB() {
        inputText1.resignFirstResponder()
        inputText2.resignFirstResponder()
    }

    //MARK: - COLOR BUTTON
    // thikubiモードの判定も行う
    @IBAction func choiceColor(_ sender: UIButton) {

        choiceColorNum = sender.tag
        self.view.backgroundColor = sender.backgroundColor
        closeButton.setTitleColor(sender.backgroundColor, for: .highlighted)

        colorBtn1.layer.borderWidth = 0
        colorBtn2.layer.borderWidth = 0
        colorBtn3.layer.borderWidth = 0
        colorBtn4.layer.borderWidth = 0
        colorBtn5.layer.borderWidth = 0

        sender.layer.borderWidth = 2

        if choiceColorNum == correctNum[secretNum.count] {
            secretNum.append(choiceColorNum)

            if secretNum == correctNum {
                secretNum = []
                print("thikubiモード！！！")
                voice1 = "ちくび"
                voice2 = "tくび"
                toStart( sender)
                self.chikubiTapped()
            } else {
                /*** 通常 ***/
                self.aroundTapped()
                /*** ---- ***/
            }
        } else {
            /*** 通常 ***/
            self.aroundTapped()
            /*** ---- ***/
            secretNum = []
        }

    }


}
