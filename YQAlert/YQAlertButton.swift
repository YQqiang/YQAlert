//
//  YQAlertButton.swift
//  YQAlertDemo
//
//  Created by sungrow on 2017/4/22.
//  Copyright © 2017年 sungrow. All rights reserved.
//

import UIKit

enum YQAlertButtonType: Int {
    case normal
    case cancel
    case destructive
}

typealias Handle = (YQAlertButton) -> ()

class YQAlertButton: UIButton {
    
    fileprivate var handleClosure: Handle?
    
    init(title: String, type: YQAlertButtonType, handle: @escaping Handle) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        handleClosure = handle
        switch type {
        case .normal:
            layer.borderWidth = YQAlertConf.buttonBorderWidth
            layer.borderColor = YQAlertConf.buttonBorderColor.cgColor
            layer.cornerRadius = YQAlertConf.cornerRadius
            setBackgroundImage(UIImage.image(YQAlertConf.buttonBackgroundColor), for: .normal)
            titleLabel?.font = YQAlertConf.buttonTitleFont
            setTitleColor(YQAlertConf.buttonTitleColor, for: .normal)
            break
        case .cancel:
            layer.borderWidth = YQAlertConf.cancelButtonBorderWidth
            layer.borderColor = YQAlertConf.cancelButtonBorderColor.cgColor
            layer.cornerRadius = YQAlertConf.cornerRadius
            setBackgroundImage(UIImage.image(YQAlertConf.cancelButtonBackgroundColor), for: .normal)
            titleLabel?.font = YQAlertConf.cancelButtonTitleFont
            setTitleColor(YQAlertConf.cancelButtonTitleColor, for: .normal)
            break
            
        case .destructive:
            layer.borderWidth = YQAlertConf.destructiveButtonBorderWidth
            layer.borderColor = YQAlertConf.destructiveButtonBorderColor.cgColor
            layer.cornerRadius = YQAlertConf.cornerRadius
            setBackgroundImage(UIImage.image(YQAlertConf.destructiveButtonBackgroundColor), for: .normal)
            titleLabel?.font = YQAlertConf.destructiveButtonTitleFont
            setTitleColor(YQAlertConf.destructiveButtonTitleColor, for: .normal)
            break
        }
        layer.masksToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        addTarget(self, action: #selector(clickButtonAction(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK:- private action
extension YQAlertButton {
    @objc fileprivate func clickButtonAction(_ sender: YQAlertButton) {
        if let alertView = UIApplication.shared.keyWindow?.subviews.first as? YQAlertView {
            alertView.dismiss()
        }
        if let handle = handleClosure {
            handle(sender)
        }
    }
}
