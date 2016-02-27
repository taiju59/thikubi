//
//  ModelController.swift
//  thikubi
//
//  Created by Taiju Aoki on 2016/02/11.
//  Copyright © 2016年 Taiju Aoki. All rights reserved.
//

/*
A controller object that manages a simple model -- a collection of month names.

The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.

There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
*/

protocol ModelControllerDelegate: class {
    func modelController(modelController: ModelController, pageIndex index: Int)
}

class ModelController: NSObject, UIPageViewControllerDataSource, ContentViewControllerDelegate {
    
    weak var delegate: ModelControllerDelegate?
    
    var pageArray: [Int] = (!NSUserDefaults.standardUserDefaults().boolForKey(Keys.FIRST_LAUNCH)) ? [1, 2, 3, 4, 5]:[1, 2, 3]
    
    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> ContentViewController? {
        // Return the data view controller for the given index.
        if self.pageArray.count == 0 || index >= self.pageArray.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let contentViewController = storyboard.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
        contentViewController.pageIndex = self.pageArray[index]
        contentViewController.delegate = self
        return contentViewController
    }
    
    func indexOfViewController(viewController: ContentViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        return pageArray.indexOf(viewController.pageIndex) ?? NSNotFound
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! ContentViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! ContentViewController)
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.pageArray.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func contentViewController(contentViewController: ContentViewController, pageIndex index: Int) {
        delegate?.modelController(self, pageIndex: index)
    }
    
    
}
