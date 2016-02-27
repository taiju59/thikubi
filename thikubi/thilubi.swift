//
//  thilubi.swift
//  thikubi
//
//  Created by Taiju Aoki on 2015/10/23.
//  Copyright © 2015年 Taiju Aoki. All rights reserved.
//

import UIKit

class thikubi: UIView {
    
    @IBOutlet weak var dispBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func touched(sender: AnyObject) {
        
        var yomiageStr = ""
        
        if THIKUBI_ALL || sender.tag == 1 {
            chikubiTapped()
            yomiageStr = voice2
        } else if sender.tag == 2
            || sender.tag == 3
            || (sender.tag == 4/* && nowMode == "easy"*/) {
                aroundTapped()
                yomiageStr = voice1
        } else {
            touchExceptChikubi()
            yomiageStr = "Don't touch me!"
        }
        
        VoiceManager.voice(yomiageStr)
    }
    
    func chikubiTapped() {
        
        UIView.animateWithDuration(
            0.2,
            animations: {() -> Void in
                self.dispBtn.transform = CGAffineTransformMakeScale(2, 2)
            }) { (Bool) -> Void in
                UIView.animateWithDuration(
                    0.3,
                    animations: {() -> Void in
                        self.dispBtn.transform = CGAffineTransformIdentity
                    },
                    completion: nil
                )
        }
    }
    
    func aroundTapped() {
        UIView.animateWithDuration(
            0.1,
            delay:0.0,
            options:.AllowUserInteraction,
            animations: {() -> Void in
                self.dispBtn.transform = CGAffineTransformMakeScale(1.2, 1.2)
            }) { (Bool) -> Void in
                UIView.animateWithDuration(
                    0.05,
                    delay:0.0,
                    options:.AllowUserInteraction,
                    animations: {() -> Void in
                        self.dispBtn.transform = CGAffineTransformIdentity;
                    },
                    completion: nil
                )
        }
    }
    
    func touchExceptChikubi() {
        UIView.animateWithDuration(
            0.1,
            animations: {() -> Void in
                self.dispBtn.transform = CGAffineTransformMakeScale(0.5, 0.5)
            }) { (Bool) -> Void in
                UIView.animateWithDuration(
                    0.1,
                    delay:0.0,
                    options:.AllowUserInteraction,
                    animations: {() -> Void in
                        self.dispBtn.transform = CGAffineTransformIdentity
                    },
                    completion: nil
                )
        }
    }

    
    
    
    
    
    
}
