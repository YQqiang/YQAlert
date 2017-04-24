//
//  YQAlertView.swift
//  YQAlertDemo
//
//  Created by sungrow on 2017/4/21.
//  Copyright © 2017年 sungrow. All rights reserved.
//

import UIKit

let MainScreenRect = UIScreen.main.bounds

class YQAlertView: UIView {
    
    var tapToDismiss: Bool = false
    
    var isSyncAlert: Bool = false
    
    /// 自定义头部视图
    var customHeadView: UIView?
    
    /// 默认的标题视图
    var titleView: YQAlertTitleView?
    
    /// 自定义内容视图
    var custonContentView: UIView?
    
    /// 自定义底部视图
    var customBottomView: UIView?
    
    /// 默认的按钮视图
    var buttonView: YQAlertButtonView?
    var alertButtonLayoutAxis: YQAlertButtonLayoutAxis? {
        didSet {
            guard let alertButtonLayoutAxis = alertButtonLayoutAxis  else {
                return
            }
            switch alertButtonLayoutAxis {
            case .horizontal:
                buttonView?.alertButtonLayoutAxis = .horizontal
                break
            case .vertical:
                buttonView?.alertButtonLayoutAxis = .vertical
            }
        }
    }

    fileprivate let alertWindow = UIWindow(frame: MainScreenRect)
    let alertView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = MainScreenRect
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        backgroundColor = UIColor(white: 0.6, alpha: 0.4)
        
        alertView.backgroundColor = YQAlertConf.backgroundColor
        alertView.layer.cornerRadius = YQAlertConf.cornerRadius
        addSubview(alertView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if tapToDismiss {
            dismiss()
        } else {
            if alertButtonLayoutAxis == .vertical {
                dismiss()
            }
        }
    }
}

// MARK:- show & dismiss
extension YQAlertView {
    func show() {
        alertWindow.windowLevel = UIWindowLevelAlert
        alertWindow.backgroundColor = UIColor.clear
        alertWindow.becomeKey()
        alertWindow.makeKeyAndVisible()
        alertWindow.addSubview(self)
        animationToShowOrDismiss(true)
    }
    
    func dismiss() {
        animationToShowOrDismiss(false)
        
//        self.removeFromSuperview()
//        self.alertWindow.resignFirstResponder()
    }
    
    fileprivate func animationToShowOrDismiss(_ isShow: Bool) {
        let originScale: CGFloat = isShow ? 1.1 : 1.0
        let targetScale: CGFloat = isShow ? 1.0 : 1.1
        
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.transform = CGAffineTransform.init(scaleX: originScale, y: originScale)
        }) { (compelete) in
            UIView.animate(withDuration: 0.25, animations: {
                self.alertView.transform = CGAffineTransform.init(scaleX: targetScale, y: targetScale)
            }) { (complete) in
                if !isShow {
                    self.removeFromSuperview()
                    self.alertWindow.resignFirstResponder()
                }
            }
        }
        
    }
}
