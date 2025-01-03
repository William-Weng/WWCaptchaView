//
//  Delegate.swift
//  WWCaptchaView
//
//  Created by William.Weng on 2025/1/3.
//

import UIKit

// MARK: - WWCaptchaViewDelegate
public protocol WWCaptchaViewDelegate: AnyObject {
    
    /// 畫面被點到
    /// - Parameters:
    ///   - captchaView: WWCaptchaView
    ///   - didTouched: Set<UITouch>
    func captchaView(_ captchaView: WWCaptchaView, didTouched touchs: Set<UITouch>)
    
    /// 取得驗證碼
    /// - Parameters:
    ///   - captchaView: WWCaptchaView
    ///   - string: 驗證碼
    func captchaView(_ captchaView: WWCaptchaView, string: String?)
}
