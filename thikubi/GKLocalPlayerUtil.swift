//
//  GKLocalPlayerUtil.swift
//  thikubi
//
//  Created by Taiju Aoki on 2015/12/23.
//  Copyright © 2015年 Taiju Aoki. All rights reserved.
//

import UIKit
import GameKit

struct GKLocalPlayerUtil {
    static var localPlayer:GKLocalPlayer = GKLocalPlayer();
    
    static func login(target: UIViewController){
        self.localPlayer = GKLocalPlayer.local
        self.localPlayer.authenticateHandler = {(viewController, error) -> Void in
            if viewController != nil {
                print("LoginCheck: Failed - LoginPageOpen")
                target.present(viewController!, animated: true, completion: nil);
            } else {
                print("LoginCheck: Success")
                if error == nil {
                    print("LoginAuthentication: Success")
                } else {
                    print("LoginAuthentication: Failed\nerror :\(String(describing: error))")
                }
            }
        }
    }
}
