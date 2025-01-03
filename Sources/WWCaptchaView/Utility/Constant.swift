//
//  Constant.swift
//  WWCaptchaView
//
//  Created by William.Weng on 2025/1/3.
//

import UIKit

// MARK: - 常數
extension WWCaptchaView {
    
    /// 文字顏色類型
    public enum TextColorType {
        case mono(_ color: UIColor)         // 單色
        case gradient(_ colors: [UIColor])  // 漸層色
    }
}
