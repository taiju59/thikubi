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
        
        // ステータスバーを表示する
        UIApplication.sharedApplication().statusBarHidden = false
        
    }

    func loadXibView(nibName: String) {
        let xibView = UINib(nibName: nibName, bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        xibView.frame = self.view.frame
        self.view = xibView
    }
    
    //MARK - common settings
    //MARK: - Touched
    @IBAction func somethingTouched(sender: UIButton) {
        
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
        
        VoiceManager.voice(voice2)
        UIView.animateWithDuration(
            0.2,
            delay:0,
            options:.CurveEaseInOut,
            animations: {() -> Void in
                self.chikubiRight.transform = CGAffineTransformMakeScale(2, 2)
                self.chikubiLeft.transform = CGAffineTransformMakeScale(2, 2)
            }) { (Bool) -> Void in
                UIView.animateWithDuration(
                    0.3,
                    delay:0,
                    options:.CurveEaseInOut,
                    animations: {() -> Void in
                        self.chikubiRight.transform = CGAffineTransformIdentity
                        self.chikubiLeft.transform = CGAffineTransformIdentity
                    },
                    completion: nil
                )
        }
    }
    
    func aroundTapped() {
        
        VoiceManager.voice(voice1)
        UIView.animateWithDuration(
            0.1,
            delay:0.0,
            options:.AllowUserInteraction,
            animations: {() -> Void in
                self.chikubiRight.transform = CGAffineTransformMakeScale(1.2, 1.2)
                self.chikubiLeft.transform = CGAffineTransformMakeScale(1.2, 1.2)
            }) { (Bool) -> Void in
                UIView.animateWithDuration(
                    0.05,
                    delay:0.0,
                    options:.AllowUserInteraction,
                    animations: {() -> Void in
                        self.chikubiRight.transform = CGAffineTransformIdentity;
                        self.chikubiLeft.transform = CGAffineTransformIdentity;
                    },
                    completion: nil
                )
        }
    }
    
    func touchExceptChikubi() {
        
        VoiceManager.voice("Don't touch me!")
        UIView.animateWithDuration(
            0.1,
            delay:0,
            options:.CurveEaseInOut,
            animations: {() -> Void in
                self.chikubiRight.transform = CGAffineTransformMakeScale(0.5, 0.5)
                self.chikubiLeft.transform = CGAffineTransformMakeScale(0.5, 0.5)
            }) { (Bool) -> Void in
                UIView.animateWithDuration(
                    0.1,
                    delay:0.0,
                    options:.AllowUserInteraction,
                    animations: {() -> Void in
                        self.chikubiRight.transform = CGAffineTransformIdentity;
                        self.chikubiLeft.transform = CGAffineTransformIdentity;
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

