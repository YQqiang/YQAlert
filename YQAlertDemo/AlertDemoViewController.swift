//
//  AlertDemoViewController.swift
//  YQAlertDemo
//
//  Created by sungrow on 2017/4/27.
//  Copyright © 2017年 sungrow. All rights reserved.
//

import UIKit

class AlertDemoViewController: UIViewController {

    @IBOutlet weak var tapBackgoundToDismissSwitch: UISwitch!
    @IBOutlet weak var tapButtonToDismissSwitch: UISwitch!
    @IBOutlet weak var visualEffectSwitch: UISwitch!
    @IBOutlet weak var syncAlertSwitch: UISwitch!
    @IBOutlet weak var alertButtonLayoutAxisSwitch: UISwitch!
    @IBOutlet weak var customHeadViewSwitch: UISwitch!
    @IBOutlet weak var customContentViewSwitch: UISwitch!
    @IBOutlet weak var countButtons: UITextField!
    @IBOutlet weak var customShowAnimationSwitch: UISwitch!
    @IBOutlet weak var customDismissAnimationSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapBackgoundToDismissSwitch.setOn(false, animated: true)
        visualEffectSwitch.setOn(false, animated: true)
        alertButtonLayoutAxisSwitch.setOn(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let alertV = YQAlertNormalView(title: "标题", detail: "内容文字") { (button) in
            print(">>>>>>>>>>\(String(describing: button.titleLabel?.text))")
        }
        
        let customContentView = UIView()
        let imageV = UIImageView(image: UIImage(named: "test2.jpg"))
        imageV.translatesAutoresizingMaskIntoConstraints = false
        customContentView.addSubview(imageV)
        let topC = NSLayoutConstraint(item: customContentView, attribute: .top, relatedBy: .equal, toItem: imageV, attribute: .top, multiplier: 1.0, constant: 0)
        let bottomC = NSLayoutConstraint(item: customContentView, attribute: .bottom, relatedBy: .equal, toItem: imageV, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        let leftC = NSLayoutConstraint(item: customContentView, attribute: .left, relatedBy: .equal, toItem: imageV, attribute: .left, multiplier: 1.0, constant: 0)
        let rightC = NSLayoutConstraint(item: customContentView, attribute: .right, relatedBy: .equal, toItem: imageV, attribute: .right, multiplier: 1.0, constant: 0)
        customContentView.addConstraints([topC, bottomC, leftC, rightC])
        alertV.addContentView(content: customContentView)
        
        alertV.buttonViewToLeftAndRightMargin = (8.0, 8.0)
        alertV.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func tapBackgroundToDismiss(_ sender: UISwitch) {
        print("\(#function)>>>>>\(sender.isOn)")
        if !sender.isOn {
            tapButtonToDismissSwitch.setOn(true, animated: true)
        }
    }
    
    @IBAction func tapAlertButtonToDismiss(_ sender: UISwitch) {
        print("\(#function)>>>>>\(sender.isOn)")
        if !sender.isOn {
            tapBackgoundToDismissSwitch.setOn(true, animated: true)
        }
    }
    
    @IBAction func visualEffectAction(_ sender: UISwitch) {
        print("\(#function)>>>>>\(sender.isOn)")
    }
    
    @IBAction func syncAlertAction(_ sender: UISwitch) {
        print("\(#function)>>>>>\(sender.isOn)")
    }
    
    @IBAction func alertButtonLayoutAxisAction(_ sender: UISwitch) {
        print("\(#function)>>>>>\(sender.isOn)")
    }
    
    @IBAction func customHeadViewAction(_ sender: UISwitch) {
        print("\(#function)>>>>>\(sender.isOn)")
    }
    
    @IBAction func customContentViewAction(_ sender: UISwitch) {
        print("\(#function)>>>>>\(sender.isOn)")
    }
    
    @IBAction func countAlertButtons(_ sender: UITextField) {
    }
    
    @IBAction func shouAlertAction(_ sender: UIButton) {
        var alertButtons = [YQAlertButton]()
        var count = 0
        if Int(countButtons.text ?? "0") ?? 0 > 0 {
            count = Int(countButtons.text ?? "0") ?? 0
        }
        
        for index in 0..<count {
            let button = YQAlertButton(title: "button " + "\(index + 1)" + " 👍", type: .cancel, handle: { (button) in
                print(">>>>>>>>>>>\(String(describing: button.titleLabel?.text))")
            })
            alertButtons.append(button)
        }
        
        let alert = YQAlertNormalView(title: "标题", detail: "内容文字详细描述内容文字详细描述内容文字详细描述内容文字详细描述内容文字详细描述内容文字详细描述内容文字详细描述内容文字详细描述内容文字详细描述内容文字详细描述内容文字详细描述", alertButtons: alertButtons)
        alert.isTapBackgroundToDismiss = tapBackgoundToDismissSwitch.isOn
        alert.isClickAlertButtonToDismiss = tapButtonToDismissSwitch.isOn
        alert.visualEffectEnable = visualEffectSwitch.isOn
        alert.isSyncAlert = syncAlertSwitch.isOn
        if alertButtonLayoutAxisSwitch.isOn {
            alert.alertButtonLayoutAxis = .horizontal
        } else {
            alert.alertButtonLayoutAxis = .vertical
        }
        alert.buttonViewToLeftAndRightMargin = (8.0, 8.0)
        // 自定义头部视图
        if customHeadViewSwitch.isOn {
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
            alert.addHeadView(headView: customHeadView)
        }
        
        // 自定义内容视图
        if customContentViewSwitch.isOn {
            let customContentView = UIView()
            let imageV = UIImageView(image: UIImage(named: "test2.jpg"))
            imageV.translatesAutoresizingMaskIntoConstraints = false
            customContentView.addSubview(imageV)
            let topC = NSLayoutConstraint(item: customContentView, attribute: .top, relatedBy: .equal, toItem: imageV, attribute: .top, multiplier: 1.0, constant: 0)
            let bottomC = NSLayoutConstraint(item: customContentView, attribute: .bottom, relatedBy: .equal, toItem: imageV, attribute: .bottom, multiplier: 1.0, constant: 0)
            
            let leftC = NSLayoutConstraint(item: customContentView, attribute: .left, relatedBy: .equal, toItem: imageV, attribute: .left, multiplier: 1.0, constant: 0)
            let rightC = NSLayoutConstraint(item: customContentView, attribute: .right, relatedBy: .equal, toItem: imageV, attribute: .right, multiplier: 1.0, constant: 0)
            customContentView.addConstraints([topC, bottomC, leftC, rightC])
            alert.addContentView(content: customContentView)
        }
        
        // 自定义动画时间
        alert.showAnimationDuration = 0.25
        alert.dismissAnimationDuration = 0.25
        
        // 自定义显示动画
        if customShowAnimationSwitch.isOn {
            alert.showAnimation = { (alertView, duration) in
                alertView.transform = CGAffineTransform.init(translationX: 0, y: -800)
                UIView.animate(withDuration: duration, animations: {
                    alertView.transform = CGAffineTransform.init(translationX: 0, y: 0)
                }, completion: { (complete) in
                })
            }
        }
        
        // 自定义消失动画
        if customDismissAnimationSwitch.isOn {
            alert.dismissAnimation = { (alertView, duration) in
                UIView.animate(withDuration: duration, animations: {
                    alertView.transform = CGAffineTransform.init(translationX: 0, y: -800)
                }, completion: { (completion) in
                    
                })
            }
        }
        
        // 显示弹出框
        alert.show()
        
    }
    
    @objc fileprivate func clickButton() {
        print(">>>>>>>>>>>点击自定义视图上的按钮\(#function)")
    }
    
}
