//
//  Models.swift
//  WWCaptchaView
//
//  Created by William.Weng on 2024/3/11.
//

import UIKit

// MARK: - Models
public extension WWCaptchaView {
    
    // MARK: - 跟文字相關的設定值
    class RandomStringModel {
        
        var digits: String                              // 驗證碼文字 => "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        var length: Int                                 // 驗證碼長度
        var font: UIFont                                // 驗證碼字型
        var upperBound: Int                             // 驗證碼文字浮動大小
        var textColorType: WWCaptchaView.TextColorType  // 驗證碼文字顏色
        
        public init(digits: String, length: Int, font: UIFont, upperBound: Int, textColorType: WWCaptchaView.TextColorType) {
            self.digits = digits
            self.length = length
            self.font = font
            self.upperBound = upperBound
            self.textColorType = textColorType
        }
    }
    
    // MARK: - 跟干擾線相關的設定值
    class RandomLineModel {
        
        var count: Int          // 干擾線數量
        var width: CGFloat      // 干擾線粗細
        
        public init(count: Int, width: CGFloat) {
            self.count = count
            self.width = width
        }
    }
}
