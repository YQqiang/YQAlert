//
//  ViewController.swift
//  YQAlertDemo
//
//  Created by sungrow on 2017/4/21.
//  Copyright © 2017年 sungrow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 按钮
        let cancel = YQAlertButton.init(title: "取消", type: .cancel) { (alertButton) in
            print("点击了取消------")
        }
        let confirm = YQAlertButton.init(title: "确认1", type: .destructive) { (alertButton) in
            print("点击了确认------确认1")
        }
        let confirm1 = YQAlertButton.init(title: "22222", type: .normal) { (alertButton) in
            print("点击了确认------22222")
        }
        let confirm2 = YQAlertButton.init(title: "33333", type: .normal) { (alertButton) in
            print("点击了确认------33333")
        }
        
        let alertView = YQAlertNormalView(title: "这是主标题", detail: "这是内容文字, \n可以输入很多文字可以输入很多文字可以输入很多文字可以输入很多文字可以输入很多文字可以输入很多文字可以输入很多文字可以输入很多文字")
        alertView.insertAlertButton(confirm1, at: 0)
        alertView.insertAlertButton(confirm2, at: 2)
        alertView.appendAlertButton(cancel)
        alertView.removeAllAlertButtons()
        alertView.appendAlertButton(confirm2)
        alertView.insertAlertButton(confirm, at: 0)
        alertView.alertButtonLayoutAxis = .vertical
        alertView.isTapBackgroundToDismiss = true
//        alertView.show()
        
        let alertV = YQAlertNormalView(title: "主标题放在这", detail: "农夫三拳, 有点痛", cancelHandle: { (cancelAction) in
            print("----点击取消")
        }) { (confirmAction) in
            print("-----点击了确定")
        }
        alertV.appendAlertButton(confirm2)
        alertV.isSyncAlert = false
//        alertV.removeAllAlertButtons()
        alertV.buttonViewToLeftAndRightMargin = (8, 8)
        alertV.alertButtonToButtonMargin = 8
        alertV.removeAlertButton(1)
        alertV.alertButtonLayoutAxis = .horizontal
        
        let customContentView = UIView()
        let imageV = UIImageView(image: #imageLiteral(resourceName: "test.png"))
        imageV.translatesAutoresizingMaskIntoConstraints = false
        customContentView.addSubview(imageV)
        
        customContentView.bounds = CGRect(x: 0, y: 0, width: 100, height: 300)
        
        let topC = NSLayoutConstraint(item: customContentView, attribute: .top, relatedBy: .equal, toItem: imageV, attribute: .top, multiplier: 1.0, constant: 0)
        let bottomC = NSLayoutConstraint(item: customContentView, attribute: .bottom, relatedBy: .equal, toItem: imageV, attribute: .bottom, multiplier: 1.0, constant: 0)
        let centerX = NSLayoutConstraint(item: customContentView, attribute: .centerX, relatedBy: .equal, toItem: imageV, attribute: .centerX, multiplier: 1.0, constant: 0)
        let centerY = NSLayoutConstraint(item: customContentView, attribute: .centerY, relatedBy: .equal, toItem: imageV, attribute: .centerY, multiplier: 1.0, constant: 0)
        customContentView.addConstraints([topC, bottomC, centerX, centerY])
        
        alertV.addContentView(content: customContentView)
        alertV.isClickAlertButtonToDismiss = false
        alertV.isTapBackgroundToDismiss = true
        alertV.show()
        
        print("谁先执行, 应该是点击之后执行")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

