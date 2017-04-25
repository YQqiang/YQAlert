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
        alertV = YQAlertNormalView(title: "主标题放在这", detail: "农夫三拳, 有点痛") { (confirmAction) in
            print("-----点击了确定")
        }
        guard let alertV = alertV else {
            return
        }
//        alertV.appendAlertButton(confirm2)
        alertV.isSyncAlert = false
//        alertV.removeAllAlertButtons()
        alertV.buttonViewToLeftAndRightMargin = (8, 8)
        alertV.alertButtonToButtonMargin = 8
//        alertV.removeAlertButton(1)
        alertV.alertButtonLayoutAxis = .horizontal
        
        let customContentView = UIView()
        let imageV = UIImageView(image: UIImage(named: "test2.jpg"))
        imageV.translatesAutoresizingMaskIntoConstraints = false
        customContentView.addSubview(imageV)
        
        customContentView.bounds = CGRect(x: 0, y: 0, width: 100, height: 300)
        
        let topC = NSLayoutConstraint(item: customContentView, attribute: .top, relatedBy: .equal, toItem: imageV, attribute: .top, multiplier: 1.0, constant: 0)
        let bottomC = NSLayoutConstraint(item: customContentView, attribute: .bottom, relatedBy: .equal, toItem: imageV, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        let leftC = NSLayoutConstraint(item: customContentView, attribute: .left, relatedBy: .equal, toItem: imageV, attribute: .left, multiplier: 1.0, constant: 0)
        let rightC = NSLayoutConstraint(item: customContentView, attribute: .right, relatedBy: .equal, toItem: imageV, attribute: .right, multiplier: 1.0, constant: 0)
        
        let centerX = NSLayoutConstraint(item: customContentView, attribute: .centerX, relatedBy: .equal, toItem: imageV, attribute: .centerX, multiplier: 1.0, constant: 0)
        let centerY = NSLayoutConstraint(item: customContentView, attribute: .centerY, relatedBy: .equal, toItem: imageV, attribute: .centerY, multiplier: 1.0, constant: 0)
        customContentView.addConstraints([topC, bottomC, leftC, rightC])
        
        let button = UIButton(type: .custom)
        button.setTitle("点击按钮", for: .normal)
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        customContentView.addSubview(button)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.center = imageV.center
        
        alertV.addContentView(content: customContentView)
        alertV.isClickAlertButtonToDismiss = true
        alertV.isTapBackgroundToDismiss = true
        alertV.visualEffectEnable = false
        alertV.show()
        print("谁先执行, 应该是点击之后执行")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc fileprivate func clickButton() {
        print(">>>>>>>>>>>点击自定义视图上的按钮\(#function)")
        alertV?.dismiss()
    }

}

