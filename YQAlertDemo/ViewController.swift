//
//  ViewController.swift
//  YQAlertDemo
//
//  Created by sungrow on 2017/4/21.
//  Copyright © 2017年 sungrow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate var alertV: YQAlertNormalView?
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageV = UIImageView(image: #imageLiteral(resourceName: "test1.jpg"))
        imageV.frame = MainScreenRect
        imageV.isUserInteractionEnabled = true
        view.addSubview(imageV)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let cancel1 = YQAlertButton(title: "取消1🙄", type: .cancel) { (button) in
            
        }
        let cancel2 = YQAlertButton(title: "取消2🤔", type: .cancel) { (button) in
            
        }
        let cancel3 = YQAlertButton(title: "销毁😡", type: .destructive) { (button) in
            
        }
        
        alertV = YQAlertNormalView(title: "主标题放在这", detail: "农夫三拳, 有点痛") { (confirmAction) in
            print("-----点击了确定")
        }
        guard let alertV = alertV else {
            return
        }
        alertV.appendAlertButton(cancel1)
        alertV.appendAlertButton(cancel2)
        alertV.appendAlertButton(cancel3)
        alertV.isSyncAlert = false
//        alertV.removeAllAlertButtons()
        alertV.buttonViewToLeftAndRightMargin = (8, 8)
        alertV.alertButtonToButtonMargin = 8
//        alertV.removeAlertButton(1)
        alertV.alertButtonLayoutAxis = .vertical
        
        let customHeadView = UIView()
        let checkImageV = UIImageView(image: #imageLiteral(resourceName: "close"))
        checkImageV.translatesAutoresizingMaskIntoConstraints = false
        checkImageV.isUserInteractionEnabled = true
        checkImageV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickButton)))
        customHeadView.addSubview(checkImageV)
        let topHeadC = NSLayoutConstraint(item: customHeadView, attribute: .top, relatedBy: .equal, toItem: checkImageV, attribute: .top, multiplier: 1.0, constant: 0)
        let checkImageVRightC = NSLayoutConstraint(item: customHeadView, attribute: .right, relatedBy: .equal, toItem: checkImageV, attribute: .right, multiplier: 1.0, constant: 0)
        customHeadView.addConstraints([topHeadC, checkImageVRightC])
        
        let alertImageV = UIImageView(image: #imageLiteral(resourceName: "alert"))
        alertImageV.translatesAutoresizingMaskIntoConstraints = false
        customHeadView.addSubview(alertImageV)
        let alertImageVTopC = NSLayoutConstraint(item: customHeadView, attribute: .top, relatedBy: .equal, toItem: alertImageV, attribute: .top, multiplier: 1.0, constant: 0)
        let alertImageVBottomC = NSLayoutConstraint(item: customHeadView, attribute: .bottom, relatedBy: .equal, toItem: alertImageV, attribute: .bottom, multiplier: 1.0, constant: 0)
        let alertImageVCenterX = NSLayoutConstraint(item: customHeadView, attribute: .centerX, relatedBy: .equal, toItem: alertImageV, attribute: .centerX, multiplier: 1.0, constant: 0)
        customHeadView.addConstraints([alertImageVTopC, alertImageVBottomC, alertImageVCenterX])
        alertV.addHeadView(headView: customHeadView)
        
        let customContentView = UIView()
        let imageV = UIImageView(image: UIImage(named: "test2.jpg"))
        imageV.translatesAutoresizingMaskIntoConstraints = false
        customContentView.addSubview(imageV)
        
        customContentView.bounds = CGRect(x: 0, y: 0, width: 100, height: 300)
        
        let topC = NSLayoutConstraint(item: customContentView, attribute: .top, relatedBy: .equal, toItem: imageV, attribute: .top, multiplier: 1.0, constant: 0)
        let bottomC = NSLayoutConstraint(item: customContentView, attribute: .bottom, relatedBy: .equal, toItem: imageV, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        let leftC = NSLayoutConstraint(item: customContentView, attribute: .left, relatedBy: .equal, toItem: imageV, attribute: .left, multiplier: 1.0, constant: 0)
        let rightC = NSLayoutConstraint(item: customContentView, attribute: .right, relatedBy: .equal, toItem: imageV, attribute: .right, multiplier: 1.0, constant: 0)
        
        customContentView.addConstraints([topC, bottomC, leftC, rightC])
        
        alertV.addContentView(content: customContentView)
        alertV.isClickAlertButtonToDismiss = true
        alertV.isTapBackgroundToDismiss = true
        alertV.visualEffectEnable = true
        alertV.showAnimationDuration = 0.5
        alertV.dismissAnimationDuration = 0.5
        alertV.showAnimation = { (alertView, duration) in
            alertView.transform = CGAffineTransform.init(translationX: 0, y: -800)
            UIView.animate(withDuration: duration, animations: {
                alertView.transform = CGAffineTransform.init(translationX: 0, y: 0)
            }, completion: { (complete) in
            })
        }
        alertV.dismissAnimation = { (alertView, duration) in
            UIView.animate(withDuration: duration, animations: {
                alertView.transform = CGAffineTransform.init(translationX: 0, y: -800)
            }, completion: { (completion) in
                
            })
        }
        
        alertV.show()
        print("谁先执行, 应该是点击之后执行")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc fileprivate func clickButton() {
        print(">>>>>>>>>>>点击自定义视图上的按钮\(#function)")
//        alertV?.dismiss()
    }

}

