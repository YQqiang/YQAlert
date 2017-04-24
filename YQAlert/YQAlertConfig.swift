//
//  YQAlertConfig.swift
//  YQAlertDemo
//
//  Created by sungrow on 2017/4/21.
//  Copyright © 2017年 sungrow. All rights reserved.
//

import UIKit

public let YQAlertConf = YQAlertConfig.shared

open class YQAlertConfig {
    
    /// 单粒
    open static let shared = YQAlertConfig()
    private init() {}
    
    // MARK:- 配置弹出框样式
    
    /// 弹出框的背景颜色
    open var backgroundColor = UIColor.white
    
    /// 弹出框的圆角
    open var cornerRadius: CGFloat = 5.0;
    
    /// 渲染颜色
    open var tintColor = UIColor.white
    
    /// 控件之间垂直间距
    open var verticalMargin = 8.0
    
    /// 水平距父视图的间距(不包含按钮之间水平间距)
    open var horizontalMargin: CGFloat = 8.0
    
    /// 弹出框距左边屏幕的间距
    open var alertToLeftScreenMargin = 30
    
    /// 弹出框距右边屏幕的间距
    open var alertToRightScreenMargin = 30
    
    // MARK:- 配置标题样式
    /// 标题字体
    open var titleFont = UIFont.systemFont(ofSize: 15)
    
    /// 标题颜色
    open var titleColor = UIColor.black
    
    /// 标题的对齐方式
    open var titleAlignment: NSTextAlignment = .center
    
    /// 标题的行数
    open var titleNumberOfLines = 0
    
    // MARK:- 配置内容文字样式
    /// 标题字体
    open var detailFont = UIFont.systemFont(ofSize: 13)
    
    /// 标题颜色
    open var detailColor = UIColor.black
    
    /// 标题的对齐方式
    open var detailAlignment: NSTextAlignment = .center
    
    /// 标题的行数
    open var detailNumberOfLines = 0
    
    // MARK:- 配置按钮的样式
    // MARK:- 普通按钮
    open var buttonBorderWidth: CGFloat = 0.5
    open var buttonBorderColor = UIColor.clear
    open var buttonBackgroundColor = UIColor(hex: 0x3399fe)
    open var buttonTitleFont = UIFont.systemFont(ofSize: 17)
    open var buttonTitleColor = UIColor.white
    
    // MARK:- 取消按钮 cancel
    open var cancelButtonBorderWidth: CGFloat = 0.5
    open var cancelButtonBorderColor = UIColor.clear
    open var cancelButtonBackgroundColor = UIColor(hex: 0x3399fe)
    open var cancelButtonTitleFont = UIFont.systemFont(ofSize: 17)
    open var cancelButtonTitleColor = UIColor.white
    
    // MARK:- 警示按钮 destructive
    open var destructiveButtonBorderWidth: CGFloat = 0.5
    open var destructiveButtonBorderColor = UIColor.clear
    open var destructiveButtonBackgroundColor = UIColor.red
    open var destructiveButtonTitleFont = UIFont.systemFont(ofSize: 17)
    open var destructiveButtonTitleColor = UIColor.white
    
}
