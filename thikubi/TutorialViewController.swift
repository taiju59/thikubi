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
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController!.delegate = self
        
        let startingViewController: ContentViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in })
        
        self.pageViewController!.dataSource = self.modelController
        
        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)
        
        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
        var pageViewRect = self.view.bounds
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0)
        }
        self.pageViewController!.view.frame = pageViewRect
        
        self.pageViewController!.didMoveToParentViewController(self)
        
        // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
        self.view.gestureRecognizers = self.pageViewController!.gestureRecognizers
        
        
        // PageControlを作成する.
        pageControl = UIPageControl(frame: CGRectMake(0, self.view.frame.maxY - 50, self.view.frame.maxX, 50))
        pageControl!.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        
        // PageControlするページ数を設定する.
        pageControl!.numberOfPages = modelController.pageArray.count
        
        // 現在ページを設定する.
        pageControl!.currentPage = 0
        pageControl!.userInteractionEnabled = false
        
        self.view.addSubview(pageControl!)
        
        
        // 閉じるボタン
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        let closeButton = UIButton(frame: CGRectMake(self.view.frame.maxX - 40 - 4, statusBarHeight + 4, 30, 30))
        closeButton.addTarget(self, action: Selector("closeTutorial:"), forControlEvents: .TouchUpInside)
        closeButton.setTitle("×", forState: .Normal)
        closeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        closeButton.titleLabel?.font = UIFont(name: "Avenir-Roman", size: 30)
        closeButton.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        closeButton.layer.cornerRadius = 15
        self.view.addSubview(closeButton)
        
        // 次へボタン
        nextButton = UIButton(frame: CGRectMake(0, 0, 60, 50))
        nextButton!.center = CGPointMake(self.view.frame.maxX/5 * 4, pageControl!.center.y)
        nextButton!.addTarget(self, action: Selector("goForward:"), forControlEvents: .TouchUpInside)
        nextButton!.setTitle(String(localizeKey: Keys.WORD_NEXT), forState: .Normal)
        nextButton!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        nextButton!.titleLabel?.font = UIFont(name: "TsukushiAMaruGothic", size: 30)
        self.view.addSubview(nextButton!)
        
        // 前へボタン
//        let backButton = UIButton(frame: CGRectMake(0, 0, 60, 60))
//        backButton.center = CGPointMake(self.view.frame.maxX/5 * 1, pageControl!.center.y)
//        backButton.addTarget(self, action: Selector("closeTutorial:"/*"goForward:"*/), forControlEvents: .TouchUpInside)
//        backButton.setTitle(String(localizeKey: Keys.WORD_BACK), forState: .Normal)
//        backButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
//        backButton.titleLabel?.font = UIFont(name: "TsukushiAMaruGothic", size: 30)
//        self.view.addSubview(backButton)
        
        // スキップボタン
        skipButton = UIButton(frame: CGRectMake(0, 0, 70, 50))
        skipButton!.center = CGPointMake(self.view.frame.maxX/5 * 4, pageControl!.center.y)
        skipButton!.addTarget(self, action: Selector("closeTutorial:"), forControlEvents: .TouchUpInside)
        skipButton!.setTitle(String(localizeKey: Keys.WORD_SKIP), forState: .Normal)
        skipButton!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        skipButton!.titleLabel?.font = UIFont(name: "TsukushiAMaruGothic", size: 30)
        skipButton!.hidden = true
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
    
    func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        if (orientation == .Portrait) || (orientation == .PortraitUpsideDown) || (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
            // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to true, so set it to false here.
            let currentViewController = self.pageViewController!.viewControllers![0] as! ContentViewController
            let viewControllers = [currentViewController]
            self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
            
            self.pageViewController!.doubleSided = false
            return .Min
        }
        
        // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
        let currentViewController = self.pageViewController!.viewControllers![0] as! ContentViewController
        var viewControllers: [UIViewController]
        
        let indexOfCurrentViewController = self.modelController.indexOfViewController(currentViewController)
        if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
            let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfterViewController: currentViewController) as! ContentViewController
            viewControllers = [currentViewController, nextViewController]
        } else {
            let previousViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerBeforeViewController: currentViewController) as! ContentViewController
            viewControllers = [previousViewController, currentViewController]
        }
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
        
        return .Mid
    }
    
    func modelController(modelController: ModelController, pageIndex index: Int) {
        pageControl?.currentPage = index - 1
        if index == modelController.pageArray.count {
            nextButton?.hidden = true
            skipButton?.hidden = false
        } else {
            nextButton?.hidden = false
            skipButton?.hidden = true
        }
    }
    
    func goForward(sender: UIButton) {
        let currentViewController = self.pageViewController!.viewControllers![0] as! ContentViewController
        if pageControl?.currentPage < modelController.pageArray.count - 1 {
            if let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfterViewController: currentViewController) {
                let viewControllers = [nextViewController]
                self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
            }
        }
    }
    
    func closeTutorial(sender: UIButton) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if !NSUserDefaults.standardUserDefaults().boolForKey(Keys.FIRST_LAUNCH) {
            self.performSegueWithIdentifier("showMainView", sender: nil)
            userDefaults.setBool(true, forKey: Keys.FIRST_LAUNCH)
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
//            userDefaults.setBool(true, forKey: Keys.FINISH_TIME_TUTORIAL)
        }
        userDefaults.synchronize()
    }
}

