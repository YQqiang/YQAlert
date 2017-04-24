//
//  YQAlertButtonView.swift
//  YQAlertDemo
//
//  Created by sungrow on 2017/4/22.
//  Copyright © 2017年 sungrow. All rights reserved.
//

import UIKit

enum YQAlertButtonLayoutAxis: Int {
    case horizontal
    case vertical
}

class YQAlertButtonView: UIView {

    var alertButtons: [YQAlertButton]
    
    /// 操作按钮的排列方式: 水平-`horizontal`; 垂直-`vertical`
    var alertButtonLayoutAxis: YQAlertButtonLayoutAxis? {
        didSet {
            guard let alertButtonLayoutAxis = alertButtonLayoutAxis  else {
                return
            }
            guard let stackView = stackView else {
                return
            }
            switch alertButtonLayoutAxis {
            case .horizontal:
                stackView.axis = .horizontal
                break
            case .vertical:
                stackView.axis = .vertical
            }
        }
    }
    
    /// 操作按钮之间的间距
    var alertButtonToButtonMargin: CGFloat = 8.0 {
        didSet {
            guard let stackView = stackView else {
                return
            }
            stackView.spacing = alertButtonToButtonMargin
        }
    }
    
    fileprivate var stackView: UIStackView?
    fileprivate var vButtonViewConstraint: [NSLayoutConstraint]!
    fileprivate var hButtonViewConstraint: [NSLayoutConstraint]!
    fileprivate var topC: NSLayoutConstraint!
    fileprivate var leftC: NSLayoutConstraint!
    fileprivate var bottomC: NSLayoutConstraint!
    fileprivate var rightC: NSLayoutConstraint!
    
    init(alertButtons: [YQAlertButton]) {
        self.alertButtons = alertButtons
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension YQAlertButtonView {
    fileprivate func createUI() {
        guard alertButtons.count > 0 else {
            return
        }
        stackView = UIStackView()
        guard let stackView = stackView else {
            return
        }
        stackView.axis = .horizontal
        stackView.spacing = alertButtonToButtonMargin
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        vButtonViewConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[stackView]-(0)-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: [:], views: ["stackView": stackView])
        hButtonViewConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[stackView]-(0)-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: [:], views: ["stackView": stackView])
        addConstraints(vButtonViewConstraint)
        addConstraints(hButtonViewConstraint)
        
        for alertButton in alertButtons {
            stackView.addArrangedSubview(alertButton)
        }
        topC = NSLayoutConstraint(item: alertButtons.first!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        leftC = NSLayoutConstraint(item: alertButtons.first!, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0)
        bottomC = NSLayoutConstraint(item: alertButtons.last!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        rightC = NSLayoutConstraint(item: alertButtons.last!, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0)
        addConstraint(topC)
        addConstraint(leftC)
        addConstraint(bottomC)
        addConstraint(rightC)
    }
    
    fileprivate func updateUI() {
        guard let stackView = stackView else {
            createUI()
            return
        }
        // 更新UI, 移除原有的约束
        removeConstraints(vButtonViewConstraint)
        removeConstraints(hButtonViewConstraint)
        removeConstraint(topC)
        removeConstraint(leftC)
        removeConstraint(bottomC)
        removeConstraint(rightC)
        
        // 移除stackView管理的子视图
        for arrangedSubview in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(arrangedSubview)
            // 还需要把该子视图从父视图上移除, 否则虽然没有位置, 但是还是会显示在界面原点处
            arrangedSubview.removeFromSuperview()
        }
        
        // 如果按钮的个数为0, 则不需要安装约束
        guard alertButtons.count > 0 else {
            return
        }
        vButtonViewConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[stackView]-(0)-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: [:], views: ["stackView": stackView])
        hButtonViewConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[stackView]-(0)-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: [:], views: ["stackView": stackView])
        addConstraints(vButtonViewConstraint)
        addConstraints(hButtonViewConstraint)
        
        for alertButton in alertButtons {
            stackView.addArrangedSubview(alertButton)
        }
        topC = NSLayoutConstraint(item: alertButtons.first!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        leftC = NSLayoutConstraint(item: alertButtons.first!, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0)
        bottomC = NSLayoutConstraint(item: alertButtons.last!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        rightC = NSLayoutConstraint(item: alertButtons.last!, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0)
        addConstraint(topC)
        addConstraint(leftC)
        addConstraint(bottomC)
        addConstraint(rightC)
    }
}

extension YQAlertButtonView {
    func appendAlertButton(_ alertButton: YQAlertButton) {
        alertButtons.append(alertButton)
        updateUI()
    }
    
    func removeAlertButton(_ at: Int) {
        if at < alertButtons.count, at >= 0 {
            alertButtons.remove(at: at)
            updateUI()
        }
    }
    
    func insertAlertButton(_ alertButton: YQAlertButton, at: Int) {
        if at <= alertButtons.count, at >= 0 {
            alertButtons.insert(alertButton, at: at)
            updateUI()
        }
    }
    
    func removeAllAlertButtons() {
        alertButtons.removeAll()
        updateUI()
    }
}
