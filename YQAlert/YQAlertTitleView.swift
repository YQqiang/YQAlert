//
//  YQAlertTitleView.swift
//  YQAlertDemo
//
//  Created by sungrow on 2017/4/21.
//  Copyright © 2017年 sungrow. All rights reserved.
//

import UIKit

open class YQAlertTitleView: UIView {
    
    /// 标题
    lazy var titleLabel: UILabel = {
        let `self` = UILabel()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = YQAlertConf.titleColor
        self.textAlignment = YQAlertConf.titleAlignment
        self.numberOfLines = YQAlertConf.titleNumberOfLines
        self.font = YQAlertConf.titleFont
        return self
    }()
    
    /// 内容描述文字
    lazy var detailLabel: UILabel = {
        let `self` = UILabel()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = YQAlertConf.detailColor
        self.textAlignment = YQAlertConf.detailAlignment
        self.numberOfLines = YQAlertConf.detailNumberOfLines
        self.font = YQAlertConf.detailFont
        return self
    }()
    
    public init(_ title: String, detail: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        detailLabel.text = detail
        addSubview(titleLabel)
        addSubview(detailLabel)
        createUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CREATE UI
extension YQAlertTitleView {
    fileprivate func createUI() {
        let vTitleConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-space-[titleLabel]-space-[detailLabel]-space-|", options: [.alignAllLeft,.alignAllRight], metrics: ["space": YQAlertConf.verticalMargin], views: ["titleLabel": titleLabel, "detailLabel": detailLabel])
        let hTitleConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-space-[titleLabel]-space-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: ["space": YQAlertConf.horizontalMargin], views: ["titleLabel": titleLabel])
        
        addConstraints(vTitleConstraint)
        addConstraints(hTitleConstraint)
    }
}
