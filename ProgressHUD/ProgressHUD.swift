//
//  ProgressHUD.swift
//  ProgressHUD
//
//  Created by yuxi on 6/21/16.
//  Copyright © 2016 yuxi xiong. All rights reserved.
//

import UIKit


import UIKit

class ProgressHUD: UIVisualEffectView {
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .Dark)
    let myVisualView: UIVisualEffectView
    let originalText:String
    
    
    init(text: String) {
        self.text = text
        self.originalText = text
        self.myVisualView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.originalText = ""
        self.myVisualView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
        super.init(coder: aDecoder)
        self.setup()
        
    }
    
    func setup() {
        contentView.addSubview(myVisualView)
        myVisualView.contentView.addSubview(activityIndictor)
        myVisualView.contentView.addSubview(label)
        activityIndictor.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            
            let width = superview.frame.size.width / 2.3
            let height: CGFloat = 50.0
            self.frame = CGRectMake(superview.frame.size.width / 2 - width / 2,
                                    superview.frame.height / 2 - height / 2,
                                    width,
                                    height)
            myVisualView.frame = self.bounds
            
            let activityIndicatorSize: CGFloat = 40
            activityIndictor.frame = CGRectMake(5, height / 2 - activityIndicatorSize / 2,
                                                activityIndicatorSize,
                                                activityIndicatorSize)
            
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            label.text = text
            label.textAlignment = NSTextAlignment.Center
            label.frame = CGRectMake(activityIndicatorSize + 5, 0, width - activityIndicatorSize - 15, height)
            label.textColor = UIColor.grayColor()
            label.font = UIFont.boldSystemFontOfSize(16)
            activityIndictor.hidesWhenStopped = true
        }
    }
    
    func show() {
        self.hidden = false
        activityIndictor.startAnimating()
    }
    
    func hide() {
        self.hidden = true
        activityIndictor.stopAnimating()
    }
    
    func showAnimated() {
        if (self.alpha == 0)
        {
            self.alpha = 1;
            self.myVisualView.alpha = 0;
            
            self.myVisualView.transform = CGAffineTransformScale(myVisualView.transform, 1.4, 1.4);
            UIView.animateWithDuration(0.15, delay: 0, options:  [UIViewAnimationOptions.CurveEaseOut,UIViewAnimationOptions.AllowUserInteraction], animations: {
                self.activityIndictor.startAnimating()
                self.myVisualView.transform = CGAffineTransformScale(self.myVisualView.transform, 1/1.4, 1/1.4)
                self.myVisualView.alpha = 1
                }, completion: nil)}
    }
    
    func hideAnimated() {
        if (self.alpha == 1)
        {
            UIView.animateWithDuration(0.3, delay: 0, options:  [UIViewAnimationOptions.CurveEaseIn,UIViewAnimationOptions.AllowUserInteraction], animations: {
                self.myVisualView.transform = CGAffineTransformScale(self.myVisualView.transform, 0.7, 0.7)
                self.myVisualView.alpha = 0
                }, completion: {
                    _ in
                    self.alpha = 0
                    self.myVisualView.transform = CGAffineTransformScale(self.myVisualView.transform, 1.4, 1.4)
                    self.activityIndictor.stopAnimating()
                    self.label.text = self.originalText
            })
        }
    }
    
    func HideAnimatedWithSuccessMessage(successMessage:String, displayMessageTime:Int64) {
        let iconFrame = CGRectMake(10, 50 / 2 - 30 / 2, 30, 30)
        let successIcon = UIImageView(image: UIImage(named: "progressSuccess"))
        successIcon.frame = iconFrame
        successIcon.alpha = 0
        self.activityIndictor.stopAnimating()
        self.myVisualView.addSubview(successIcon)
        UIView.animateWithDuration(0.15, delay: 0, options: .CurveEaseOut, animations: {
            successIcon.alpha = 1
            self.label.text = successMessage
            }, completion: {_ in
                let triggerTime = (Int64(NSEC_PER_SEC) * displayMessageTime)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                    self.activityIndictor.stopAnimating()
                    successIcon.removeFromSuperview()
                    self.hideAnimated()
                })
            })
        
        
    }
    
    func hideAnimatedWithFailMessage(failMessage:String, displayMessageTime:Int64) {
        let iconFrame = CGRectMake(10, 50 / 2 - 30 / 2, 30, 30)
        let failIcon = UIImageView(image: UIImage(named: "progressFail"))
        failIcon.frame = iconFrame
        failIcon.alpha = 0
        self.myVisualView.addSubview(failIcon)
        UIView.animateWithDuration(0.15, delay: 0, options: .CurveEaseOut, animations: {
            failIcon.alpha = 1
            self.label.text = failMessage
            }, completion: {_ in
                let triggerTime = (Int64(NSEC_PER_SEC) * displayMessageTime)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                    self.activityIndictor.stopAnimating()
                    failIcon.removeFromSuperview()
                    self.hideAnimated()
                })
        })
    }
    
}
