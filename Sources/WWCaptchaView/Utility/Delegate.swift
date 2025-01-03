//
//  Delegate.swift
//  WWCaptchaView
//
//  Created by William.Weng on 2025/1/3.
//

import UIKit

// MARK: - WWCaptchaViewDelegate
public protocol WWCaptchaViewDelegate: AnyObject {
    
    /// 取得驗證碼
    /// - Parameters:
    ///   - captchaView: WWCaptchaView
    ///   - string: 驗證碼
    func captchaView(_ captchaView: WWCaptchaView, string: String?)
}
