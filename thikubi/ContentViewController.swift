//
//  ContentViewController.swift
//  thikubi
//
//  Created by Taiju Aoki on 2016/02/11.
//  Copyright © 2016年 Taiju Aoki. All rights reserved.
//

import UIKit

protocol ContentViewControllerDelegate: class {
    func contentViewController(_ contentViewController: ContentViewController, pageIndex index: Int)
}

class ContentViewController: UIViewController {
    
    weak var delegate: ContentViewControllerDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    var pageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let type = (!UserDefaults.standard.bool(forKey: Keys.FIRST_LAUNCH)) ? "tutorial":"timeAttack"
        let regionCode = String(localizeKey: Keys.REGION_CODE)
        let imageName = String(format: "%@-%@-%d", type, regionCode, pageIndex)
        self.imageView.image = UIImage(named: imageName)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.contentViewController(self, pageIndex: pageIndex)
    }
    
}

