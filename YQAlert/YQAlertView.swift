//
//  YQAlertView.swift
//  YQAlertDemo
//
//  Created by sungrow on 2017/4/21.
//  Copyright © 2017年 sungrow. All rights reserved.
//

import UIKit

internal let MainScreenRect = UIScreen.main.bounds

// `open` 只作用于类类型和类的成员
// 1. 公开访问的类, 可以在它们定义的模块中被继承, 也可以在引用它的模块中被继承
// 2. 公开访问的成员, 可以在它们定义的模块中子类中重写, 也可以在引用它的模块中的子类中重写
open class YQAlertView: UIView {
    
    /// 操作按钮水平排列:点击背景, 默认弹出框 `不消失`; 操作按钮垂直排列: 点击背景, 默认弹出框 `消失`
    open var isTapBackgroundToDismiss: Bool = false
    
    /// 是否执行同步弹出框: 默认不执行;  同步弹出框的说明
    open var isSyncAlert: Bool = false
    
    /// 点击操作按钮之后, 弹出框是否消失? 默认消失.
    open var isClickAlertButtonToDismiss: Bool = true
    
    /// 自定义头部视图
    open var customHeadView: UIView?
    
    /// 默认的标题视图
    open var titleView: YQAlertTitleView?
    
    /// 自定义内容视图
    open var customContentView: UIView?
    
    /// 自定义底部视图
    var customBottomView: UIView?
    
    /// 默认的按钮视图
    open var buttonView: YQAlertButtonView?
    open var alertButtonLayoutAxis: YQAlertButtonLayoutAxis? {
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
    
    /// 显示背景是否虚化处理; 默认不虚化
    open var visualEffectEnable: Bool = false {
        didSet {
            guard let alertView = alertView else {
                return
            }
            if visualEffectEnable {
                // 毛玻璃效果
                backgroundColor = UIColor.clear
                addSubview(visualEffectView)
                visualEffectView.contentView.addSubview(alertView)
            } else {
                // 背景不虚化
                backgroundColor = YQAlertConf.dimBackgroundColor
                addSubview(alertView)
                visualEffectView.removeFromSuperview()
            }
        }
    }
    
    /// 弹出框显示动画的执行时长
    open var showAnimationDuration = 0.25
    
    /// 弹出框消失动画的执行时长
    open var dismissAnimationDuration = 0.25
    
    /// 自定义弹出框显示动画
    open var showAnimation: ((_ alertView: UIView, _ animationDuration: Double) -> ())?
    
    /// 自定义弹出框消失动画
    open var dismissAnimation: ((_ alertView: UIView, _ animationDuration: Double) -> ())?

    fileprivate var alertWindow: YQWindow? = YQWindow(frame: MainScreenRect)
    fileprivate lazy var visualEffectView: UIVisualEffectView = {
        // 1. 毛玻璃样式
        let blurEffect = UIBlurEffect(style: .light)
        // 2. 显示毛玻璃的视图
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = MainScreenRect
        return visualEffectView
    }()
    lazy var alertView: UIView? = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = MainScreenRect
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        backgroundColor = YQAlertConf.dimBackgroundColor
        
        guard let alertView = alertView else {
            return
        }
        
        alertView.backgroundColor = YQAlertConf.backgroundColor
        alertView.layer.cornerRadius = YQAlertConf.cornerRadius
        addSubview(alertView)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBackgoundToDismiss)))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YQAlertView {
    @objc fileprivate func tapBackgoundToDismiss() {
        if isTapBackgroundToDismiss {
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
    public func show() {
        guard let alertWindow = alertWindow else {
            return
        }
        alertWindow.windowLevel = UIWindowLevelAlert
        alertWindow.backgroundColor = UIColor.clear
        alertWindow.becomeKey()
        alertWindow.makeKeyAndVisible()
        alertWindow.addSubview(self)
        if let showAnimation = showAnimation, let alertView = alertView {
            showAnimation(alertView, showAnimationDuration)
        } else {
            animationToShowOrDismiss(true)
        }
        
        // 如果是同步弹出框, 显示后需要 `CFRunLoopRun()`
        if isSyncAlert {
            CFRunLoopRun()
        }
    }
    
    public func dismiss() {
        // 如果是同步弹出框, 消失后需要 `CFRunLoopStop(CFRunLoopGetCurrent())`
        if isSyncAlert {
            CFRunLoopStop(CFRunLoopGetCurrent())
        }
        if let dismissAnimation = dismissAnimation, let alertView = alertView {
            dismissAnimation(alertView, dismissAnimationDuration)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + dismissAnimationDuration, execute: {
                self.removeFromSuperview()
                self.alertWindow?.resignFirstResponder()
                self.alertWindow = nil
                self.alertView = nil
            })
        } else {
            animationToShowOrDismiss(false)
        }
        
    }
    
    fileprivate func animationToShowOrDismiss(_ isShow: Bool) {
        let originScale: CGFloat = isShow ? 1.1 : 1.0
        let targetScale: CGFloat = isShow ? 1.0 : 1.1
        let duration = isShow ? showAnimationDuration : dismissAnimationDuration
        
        UIView.animate(withDuration: duration, animations: {
            self.alertView?.transform = CGAffineTransform.init(scaleX: originScale, y: originScale)
        }) { (compelete) in
            UIView.animate(withDuration: duration, animations: {
                self.alertView?.transform = CGAffineTransform.init(scaleX: targetScale, y: targetScale)
            }) { (complete) in
                if !isShow {
                    self.removeFromSuperview()
                    self.alertWindow?.resignFirstResponder()
                    self.alertWindow = nil
                    self.alertView = nil
                }
            }
        }
        
    }
}
