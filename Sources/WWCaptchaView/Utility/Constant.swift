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
        case mono(_ color: UIColor = .black, _ isTransform: Bool = true)                        // 單色 (顏色, 隨機轉動)
        case random(_ isTransform: Bool = true)                                                 // 隨機色 (隨機轉動)
        case gradient(_ colors: [UIColor] = [.red, .green, .blue], _ isTransform: Bool = true)  // 漸層色 (顏色群, 隨機轉動)
    }
}
