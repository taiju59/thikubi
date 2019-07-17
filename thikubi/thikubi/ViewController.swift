//
//  ViewController.swift
//  thikubi
//
//  Created by Taiju Aoki on 2015/10/02.
//  Copyright © 2015年 Taiju Aoki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chikubiLeft: UIButton!
    @IBOutlet weak var chikubiRight: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override var prefersStatusBarHidden: Bool {
        // ステータスバーを表示する
        return true
    }

    func loadXibView(nibName: String) {
        let xibView = UINib(nibName: nibName, bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        xibView.frame = self.view.frame
        self.view = xibView
    }
    
    //MARK - common settings
    //MARK: - Touched
    @IBAction func somethingTouched(_ sender: UIButton) {
        
        if THIKUBI_ALL || sender.tag == 1 {
            chikubiTapped()
        } else if sender.tag == 2
            || sender.tag == 3
            || (sender.tag == 4/* && nowMode == "easy"*/) {
                aroundTapped()
        } else {
            touchExceptChikubi()
        }
        
    }
    
    func chikubiTapped() {
        
        VoiceManager.voice(yomiageStr: voice2)
        UIView.animate(withDuration:
            0.2,
            delay:0,
            options:.curveEaseInOut,
            animations: {() -> Void in
                self.chikubiRight.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.chikubiLeft.transform = CGAffineTransform(scaleX: 2, y: 2)
            }) { (Bool) -> Void in
                UIView.animate(withDuration:
                    0.3,
                    delay:0,
                    options:.curveEaseInOut,
                    animations: {() -> Void in
                        self.chikubiRight.transform = .identity
                        self.chikubiLeft.transform = .identity
                    },
                    completion: nil
                )
        }
    }
    
    func aroundTapped() {
        
        VoiceManager.voice(yomiageStr: voice1)
        UIView.animate(withDuration:
            0.1,
            delay:0.0,
            options:.allowUserInteraction,
            animations: {() -> Void in
                self.chikubiRight.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                self.chikubiLeft.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { (Bool) -> Void in
                UIView.animate(withDuration:
                    0.05,
                    delay:0.0,
                    options:.allowUserInteraction,
                    animations: {() -> Void in
                        self.chikubiRight.transform = .identity;
                        self.chikubiLeft.transform = .identity;
                    },
                    completion: nil
                )
        }
    }
    
    func touchExceptChikubi() {
        
        VoiceManager.voice(yomiageStr: "Don't touch me!")
        UIView.animate(withDuration:
            0.1,
            delay:0,
            options:.curveEaseInOut,
            animations: {() -> Void in
                self.chikubiRight.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.chikubiLeft.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }) { (Bool) -> Void in
                UIView.animate(withDuration:
                    0.1,
                    delay:0.0,
                    options:. allowUserInteraction,
                    animations: {() -> Void in
                        self.chikubiRight.transform = .identity;
                        self.chikubiLeft.transform = .identity;
                    },
                    completion: nil
                )
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

