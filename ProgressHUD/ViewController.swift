//
//  ViewController.swift
//  ProgressHUD
//
//  Created by yuxi on 6/21/16.
//  Copyright © 2016 yuxi xiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let progressHUD = ProgressHUD(text: "Loading...")
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(progressHUD)
        let showButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        let hideButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        showButton.setTitle("show", forState: .Normal)
        hideButton.setTitle("hide", forState: .Normal)
        showButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        hideButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        showButton.setTitleColor(UIColor.yellowColor(), forState: .Highlighted)
        hideButton.setTitleColor(UIColor.yellowColor(), forState: .Highlighted)
        showButton.addTarget(self, action: #selector(ViewController.showProgressHUD), forControlEvents: .TouchUpInside)
        hideButton.addTarget(self, action: #selector(ViewController.hideProgressHUD), forControlEvents: .TouchUpInside)
        showButton.center = CGPoint(x: screenWidth/3, y: screenHeight*7/8)
        hideButton.center = CGPoint(x: screenWidth*2/3, y: screenHeight*7/8)
        self.view.addSubview(showButton)
        self.view.addSubview(hideButton)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        progressHUD.alpha = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showProgressHUD(){
        progressHUD.showAnimated()
    }
    
    func hideProgressHUD(){
        progressHUD.HideAnimatedWithSuccessMessage("Successful", displayMessageTime: 1)
        //progressHUD.hideAnimatedWithFailMessage("Fail", displayMessageTime: 1)
    }


}

