//
//  YQAlertNormalView.swift
//  YQAlertDemo
//
//  Created by sungrow on 2017/4/21.
//  Copyright © 2017年 sungrow. All rights reserved.
//

import UIKit

class YQAlertNormalView: YQAlertView {
    
    /// 按钮距左边和右边的边距, 默认左右给为30;
    open var buttonViewToLeftAndRightMargin: (left: CGFloat, right: CGFloat) = (30.0, 30.0) {
        didSet {
            guard var hButtonViewConstraint = hButtonViewConstraint, let buttonView = buttonView else {
                return
            }
            removeConstraints(hButtonViewConstraint)
            hButtonViewConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(space)-[buttonView]-(space1)-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: ["space": buttonViewToLeftAndRightMargin.left, "space1": buttonViewToLeftAndRightMargin.right], views: ["buttonView": buttonView])
            addConstraints(hButtonViewConstraint)
        }
    }
    
    /// 按钮和按钮之间的间距; 默认值为8
    open var alertButtonToButtonMargin: CGFloat? {
        didSet {
            guard let alertButtonToButtonMargin = alertButtonToButtonMargin, let buttonView = buttonView else {
                return
            }
            buttonView.alertButtonToButtonMargin = alertButtonToButtonMargin
        }
    }

    fileprivate var hButtonViewConstraint: [NSLayoutConstraint]?
    fileprivate var vButtonViewConstraint: [NSLayoutConstraint]?
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
        alertView?.translatesAutoresizingMaskIntoConstraints = false
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
    ///   - confirmTitle: 确认按钮的标题, 默认为 `确认`
    ///   - confirmType: 确认按钮的类型, 枚举值`YQAlertButtonType`; 默认为 `normal`
    ///   - confirmHandle: 点击确认按钮的回调
    init(title: String, detail: String, confirmTitle: String = NSLocalizedString("确认", comment: ""), confirmType: YQAlertButtonType = .normal, confirmHandle: @escaping Handle) {
        super.init(frame: .zero)
        titleView = YQAlertTitleView(title, detail: detail)
        let confirm = YQAlertButton(title: confirmTitle, type: confirmType, handle: confirmHandle)
        buttonView = YQAlertButtonView(alertButtons: [confirm])
        titleView?.translatesAutoresizingMaskIntoConstraints = false
        alertView?.translatesAutoresizingMaskIntoConstraints = false
        createUI()
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
        alertView?.translatesAutoresizingMaskIntoConstraints = false
        createUI()
    }
    
    deinit {
        print("弹出框释放了")
    }

}

// MARK: - CREATE UI
extension YQAlertNormalView {
    fileprivate func createUI() {
        // 标题和内容
        guard let titleView = titleView else {
            return
        }
        guard let alertView = alertView else {
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
        
        // 操作按钮
        guard let buttonView = buttonView else {
            return
        }
        
        buttonView.alertButtonLayoutAxis = alertButtonLayoutAxis
        alertView.addSubview(buttonView)
        
        vButtonViewConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:[titleView]-space-[buttonView]-space-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: ["space": YQAlertConf.verticalMargin], views: ["titleView": titleView, "buttonView": buttonView])
        hButtonViewConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(space)-[buttonView]-(space1)-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: ["space": buttonViewToLeftAndRightMargin.left, "space1": buttonViewToLeftAndRightMargin.right], views: ["buttonView": buttonView])
        addConstraints(vButtonViewConstraint!)
        addConstraints(hButtonViewConstraint!)
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

// MARK: - 增加内容视图
extension YQAlertNormalView {
    func addContentView(content: UIView) {
        if content === customContentView {
            return
        }
        // 自定义中间内容
        customContentView = content
        customContentView?.translatesAutoresizingMaskIntoConstraints = false
        guard let customContentView = customContentView else {
            return
        }
        guard let titleView = titleView else {
            return
        }
        guard var vButtonViewConstraint = vButtonViewConstraint else {
            return
        }
        
        removeConstraints(vButtonViewConstraint)
        
        alertView?.addSubview(customContentView)
        let vContentViewConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:[titleView]-(space)-[customContentView]-(>=space)-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: ["space": YQAlertConf.verticalMargin], views: ["titleView": titleView, "customContentView": customContentView])
        let hContentViewConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-space-[customContentView]-space-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: ["space": YQAlertConf.horizontalMargin], views: ["customContentView": customContentView])
        
        addConstraints(vContentViewConstraint)
        addConstraints(hContentViewConstraint)
        
        // 操作按钮
        guard let buttonView = buttonView else {
            return
        }
        
        buttonView.alertButtonLayoutAxis = alertButtonLayoutAxis
        alertView?.addSubview(buttonView)
        
        vButtonViewConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:[customContentView]-space-[buttonView]-space-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: ["space": YQAlertConf.verticalMargin], views: ["customContentView": customContentView, "buttonView": buttonView])
        addConstraints(vButtonViewConstraint)
    }
}
