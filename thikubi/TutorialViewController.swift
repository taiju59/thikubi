//
//  TutorialViewController.swift
//  thikubi
//
//  Created by Taiju Aoki on 2016/02/11.
//  Copyright © 2016年 Taiju Aoki. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, UIPageViewControllerDelegate, ModelControllerDelegate {

    private var pageViewController: UIPageViewController?
    private var pageControl: UIPageControl?

    private var nextButton: UIButton?
    private var skipButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Configure the page view controller and add it as a child view controller.
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewController!.delegate = self

        let startingViewController: ContentViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })

        self.pageViewController!.dataSource = self.modelController

        self.addChild(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)

        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
        var pageViewRect = self.view.bounds
        if UIDevice.current.userInterfaceIdiom == .pad {
            pageViewRect = pageViewRect.insetBy(dx: 40.0, dy: 40.0)
        }
        self.pageViewController!.view.frame = pageViewRect

        self.pageViewController!.didMove(toParent: self)

        // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
        self.view.gestureRecognizers = self.pageViewController!.gestureRecognizers


        // PageControlを作成する.
        pageControl = UIPageControl(frame: CGRect(x: 0, y: self.view.frame.maxY - 50, width: self.view.frame.maxX, height: 50))
        pageControl!.backgroundColor = UIColor(white: 0.3, alpha: 0.3)

        // PageControlするページ数を設定する.
        pageControl!.numberOfPages = modelController.pageArray.count

        // 現在ページを設定する.
        pageControl!.currentPage = 0
        pageControl!.isUserInteractionEnabled = false

        self.view.addSubview(pageControl!)


        // 閉じるボタン
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let closeButton = UIButton(frame: CGRect(x: self.view.frame.maxX - 40 - 4, y: statusBarHeight + 4, width: 30, height: 30))
        closeButton.addTarget(self, action: #selector(self.closeTutorial), for: .touchUpInside)
        closeButton.setTitle("×", for: .normal)
        closeButton.setTitleColor(UIColor.white, for: .normal)
        closeButton.titleLabel?.font = UIFont(name: "Avenir-Roman", size: 30)
        closeButton.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        closeButton.layer.cornerRadius = 15
        self.view.addSubview(closeButton)

        // 次へボタン
        nextButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 50))
        nextButton!.center = CGPoint(x: self.view.frame.maxX/5 * 4, y: pageControl!.center.y)
        nextButton!.addTarget(self, action: #selector(self.goForward), for: .touchUpInside)
        nextButton!.setTitle(String(localizeKey: Keys.WORD_NEXT), for: .normal)
        nextButton!.setTitleColor(UIColor.white, for: .normal)
        nextButton!.titleLabel?.font = UIFont(name: "TsukushiAMaruGothic", size: 30)
        self.view.addSubview(nextButton!)

        // 前へボタン
//        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
//        backButton.center = CGPoint(x: self.view.frame.maxX/5 * 1, y: pageControl!.center.y)
//        backButton.addTarget(self, action: #selector(self.closeTutorial), for: .touchUpInside)
//        backButton.setTitle(String(localizeKey: Keys.WORD_BACK), for: .normal)
//        backButton.setTitleColor(UIColor.white, for: .normal)
//        backButton.titleLabel?.font = UIFont(name: "TsukushiAMaruGothic", size: 30)
//        self.view.addSubview(backButton)

        // スキップボタン
        skipButton = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 50))
        skipButton!.center = CGPoint(x: self.view.frame.maxX/5 * 4, y: pageControl!.center.y)
        skipButton!.addTarget(self, action: #selector(self.closeTutorial), for: .touchUpInside)
        skipButton!.setTitle(String(localizeKey: Keys.WORD_SKIP), for: .normal)
        skipButton!.setTitleColor(UIColor.white, for: .normal)
        skipButton!.titleLabel?.font = UIFont(name: "TsukushiAMaruGothic", size: 30)
        skipButton!.isHidden = true
        self.view.addSubview(skipButton!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var modelController: ModelController {
        // Return the model controller object, creating it if necessary.
        // In more complex implementations, the model controller may be passed to the view controller.
        if _modelController == nil {
            _modelController = ModelController()
        }
        _modelController?.delegate = self
        return _modelController!
    }

    var _modelController: ModelController? = nil

    // MARK: - UIPageViewController delegate methods

    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewController.SpineLocation {
        if (orientation == .portrait) || (orientation == .portraitUpsideDown) || (UIDevice.current.userInterfaceIdiom == .phone) {
            // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to true, so set it to false here.
            let currentViewController = self.pageViewController!.viewControllers![0] as! ContentViewController
            let viewControllers = [currentViewController]
            self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })

            self.pageViewController!.isDoubleSided = false
            return .min
        }

        // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
        let currentViewController = self.pageViewController!.viewControllers![0] as! ContentViewController
        var viewControllers: [UIViewController]

        let indexOfCurrentViewController = self.modelController.indexOfViewController(currentViewController)
        if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
            let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfter: currentViewController) as! ContentViewController
            viewControllers = [currentViewController, nextViewController]
        } else {
            let previousViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerBefore: currentViewController) as! ContentViewController
            viewControllers = [previousViewController, currentViewController]
        }
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })

        return .mid
    }

    func modelController(_ modelController: ModelController, pageIndex index: Int) {
        pageControl?.currentPage = index - 1
        if index == modelController.pageArray.count {
            nextButton?.isHidden = true
            skipButton?.isHidden = false
        } else {
            nextButton?.isHidden = false
            skipButton?.isHidden = true
        }
    }

    @objc func goForward(sender: UIButton) {
        let currentViewController = self.pageViewController!.viewControllers![0] as! ContentViewController
        if let pc = pageControl, pc.currentPage < modelController.pageArray.count - 1 {
            print(pc.currentPage)
            if let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfter: currentViewController) {
                let viewControllers = [nextViewController]
                self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })
            }
        }
    }

    @objc func closeTutorial(sender: UIButton) {
        let userDefaults = UserDefaults.standard
        if !UserDefaults.standard.bool(forKey: Keys.FIRST_LAUNCH) {
            self.performSegue(withIdentifier: "showMainView", sender: nil)
            userDefaults.set(true, forKey: Keys.FIRST_LAUNCH)
        } else {
            self.dismiss(animated: true, completion: nil)
//            userDefaults.set(true, forKey: Keys.FINISH_TIME_TUTORIAL)
        }
        userDefaults.synchronize()
    }
}

