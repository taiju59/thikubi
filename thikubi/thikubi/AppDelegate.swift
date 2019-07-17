//
//  AppDelegate.swift
//  thikubi
//
//  Created by Taiju Aoki on 2015/10/02.
//  Copyright © 2015年 Taiju Aoki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController")
            window.backgroundColor = UIColor.white
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }
        // GameCenter Auto Login
        if let presentView = window?.rootViewController {
            let targetViewController = presentView
            GKLocalPlayerUtil.login(target: targetViewController)
        }

        /**
        チュートリアル起動処理
        */
        // 初回起動時はこっち
        let userDefaults = UserDefaults.standard
        let firstLaunch = !userDefaults.bool(forKey: Keys.FIRST_LAUNCH)
        let needTimeModeTutorial = userDefaults.bool(forKey: Keys.RELEASE_TIME_MODE) && !userDefaults.bool(forKey: Keys.FINISH_TIME_TUTORIAL)
        if firstLaunch/* || needTimeModeTutorial*/ {
            // チュートリアル画面を表示
            // Storyboard を呼ぶ
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

            // Storyboard の中のどの ViewContorller を呼ぶか
            // @""の中は Storyboard IDを記述する。ココ間違えばブラック画面かな。
            let vc = storyboard.instantiateViewController(withIdentifier: "TutorialViewController")
            // その画面を表示させる
            self.window?.rootViewController = vc

            if needTimeModeTutorial {
            // 説明中終了した場合変なタイミングで説明が入るため 表示 = 説明完了 と捉える
                userDefaults.set(true, forKey: Keys.FINISH_TIME_TUTORIAL)
            userDefaults.synchronize()
            }
        }


        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

