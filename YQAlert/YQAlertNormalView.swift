//
//  YQAlertNormalView.swift
//  YQAlertDemo
//
//  Created by sungrow on 2017/4/21.
//  Copyright © 2017年 sungrow. All rights reserved.
//

import UIKit

class YQAlertNormalView: YQAlertView {

    /// 创建弹出框
    ///
    /// - Parameters:
    ///   - title: 弹出框的标题
    ///   - detail: 弹出框的内容
    ///   - alertButtons: 操作按钮的数组, 可使用`YQAlertButton` 创建按钮, 并构建数组; 默认为空数组 []
    init(title: String, detail: String, alertButtons: [YQAlertButton] = []) {
        super.init(frame: .zero)
        titleView = YQAlertTitleView(title, detail: detail)
        buttonView = YQAlertButtonView(alertButtons: alertButtons)
        titleView?.translatesAutoresizingMaskIntoConstraints = false
        alertView.translatesAutoresizingMaskIntoConstraints = false
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 创建弹出框
    ///
    /// - Parameters:
    ///   - title: 弹出框的标题
    ///   - detail: 弹出框的内容
    ///   - cancelTitle: 取消按钮的标题, 默认为 `取消`
    ///   - cancelType: 取消按钮的类型, 枚举值`YQAlertButtonType`; 默认为 `cancel`
    ///   - cancelHandle: 点击取消按钮的回调
    ///   - confirmTitle: 确认按钮的标题, 默认为 `确认`
    ///   - confirmType: 确认按钮的类型, 枚举值`YQAlertButtonType`; 默认为 `normal`
    ///   - confirmHandle: 点击确认按钮的回调
    init(title: String, detail: String, cancelTitle: String = NSLocalizedString("取消", comment: ""), cancelType: YQAlertButtonType = .cancel, cancelHandle: @escaping Handle, confirmTitle: String = NSLocalizedString("确认", comment: ""), confirmType: YQAlertButtonType = .normal, confirmHandle: @escaping Handle) {
        super.init(frame: .zero)
        titleView = YQAlertTitleView(title, detail: detail)
        let cancel = YQAlertButton(title: cancelTitle, type: cancelType, handle: cancelHandle)
        let confirm = YQAlertButton(title: confirmTitle, type: confirmType, handle: confirmHandle)
        buttonView = YQAlertButtonView(alertButtons: [cancel, confirm])
        titleView?.translatesAutoresizingMaskIntoConstraints = false
        alertView.translatesAutoresizingMaskIntoConstraints = false
        createUI()
    }

}

// MARK: - CREATE UI
extension YQAlertNormalView {
    fileprivate func createUI() {
        // 标题和内容
        guard let titleView = titleView else {
            return
        }
        
        let hAlertViewConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(space)-[alertView]-space1-|", options: .directionLeadingToTrailing, metrics: ["space": YQAlertConf.alertToLeftScreenMargin, "space1": YQAlertConf.alertToRightScreenMargin], views: ["alertView": alertView])
        addConstraints(hAlertViewConstraint)
        
        alertView.addSubview(titleView)
        let vTitleViewConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-space-[titleView]-(>=space)-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: ["space": YQAlertConf.verticalMargin], views: ["titleView": titleView])
        let hTitleViewConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-space-[titleView]-space-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: ["space": YQAlertConf.horizontalMargin], views: ["titleView": titleView])
        
        let centerXConstraint = NSLayoutConstraint(item: alertView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: alertView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        
        addConstraints(vTitleViewConstraint)
        addConstraints(hTitleViewConstraint)
        addConstraint(centerXConstraint)
        addConstraint(centerYConstraint)
        
        guard let buttonView = buttonView else {
            return
        }
        
        buttonView.alertButtonLayoutAxis = alertButtonLayoutAxis
        alertView.addSubview(buttonView)
        
        let vButtonViewConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:[titleView]-space-[buttonView]-space-|", options: [.alignAllTrailing, .alignAllLeading], metrics: ["space": YQAlertConf.verticalMargin], views: ["titleView": titleView, "buttonView": buttonView])
        addConstraints(vButtonViewConstraint)
        
    }
}

// MARK:- 操作按钮的增加, 插入 和 删除
extension YQAlertNormalView {
    
    /// 追加操作按钮
    ///
    /// - Parameter alertButton: 需要追加的按钮, 可使用 `YQAlertButton` 创建
    func appendAlertButton(_ alertButton: YQAlertButton) {
        buttonView?.appendAlertButton(alertButton)
    }
    
    /// 删除指定位置的操作按钮
    ///
    /// - Parameter at: 指定位置下标
    func removeAlertButton(_ at: Int) {
        buttonView?.removeAlertButton(at)
    }
    
    /// 在指定位置插入操作按钮
    ///
    /// - Parameters:
    ///   - alertButton: 需要插入的按钮, 可使用 `YQAlertButton` 创建
    ///   - at: 插入位置下标
    func insertAlertButton(_ alertButton: YQAlertButton, at: Int) {
        buttonView?.insertAlertButton(alertButton, at: at)
    }
    
    /// 删除所有的操作按钮
    func removeAllAlertButtons() {
        buttonView?.removeAllAlertButtons()
    }
}
