//
//  Extension.swift
//  WWCaptchaView
//
//  Created by William.Weng on 2024/3/11.
//

import UIKit
import GameKit

// MARK: - Int (static function)
extension Int {
    
    /// [取得亂數](https://developer.apple.com/documentation/gameplaykit/gkrandomdistribution)
    /// - Parameter upperBound: 0..<upperBound => [Int.random(in: 1...5)](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/swift-4-2-更方便的亂數-random-function-85fa69a08215)
    /// - Returns: Int
    static func _random(upperBound: Int) -> Int {
        let number = GKRandomSource.sharedRandom().nextInt(upperBound: upperBound)
        return number
    }
}

// MARK: - String (static function)
extension String {
    
    /// [隨機字串](https://appcoda.com.tw/swift-random-number/)
    /// - Returns: String
    /// - Parameters:
    ///   - length: 字串長度
    ///   - digits: 要隨機選擇的字串
    static func _random(length: Int, by digits: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890") -> String {
        let element = Array(0..<length).compactMap { _ in return digits.randomElement() }
        return String(element)
    }
}

// MARK: - UIColor (static function)
extension UIColor {
    
    /// 隨機顏色
    /// - Returns: UIColor
    static func _random() -> UIColor { return UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1.0)}
}

// MARK: - UIFont (function)
extension UIFont {
    
    /// 估計此字型的一個字元尺寸大小
    /// - Parameters:
    ///   - character: Character
    ///   - font: UIFont
    /// - Returns: CGSize
    func _estimateCharacterSize(_ character: Character = "龘") -> CGSize {
        let size = NSString(string: "\(character)").size(withAttributes: [NSAttributedString.Key.font : self])
        return size
    }
}

// MARK: - CALayer (function)
extension CALayer {
    
    /// 設定位置大小
    /// - Parameter frame: CGRect
    /// - Returns: Self
    func _frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
}

// MARK: - CAGradientLayer (function)
extension CAGradientLayer {
    
    /// 設定漸層的方向
    /// - Parameters:
    ///   - startPoint: CGPoint
    ///   - endPoint: CGPoint
    /// - Returns: Self
    func _point(from startPoint: CGPoint, to endPoint: CGPoint) -> Self {
        self.startPoint = startPoint
        self.endPoint = endPoint
        return self
    }
    
    /// 設定endPoint
    /// - Parameter endPoint: CGPoint
    /// - Returns: Self
    func _endPoint(_ endPoint: CGPoint) -> Self { self.endPoint = endPoint; return self }
    
    /// 設定漸層顏色
    /// - Parameter colors: [UIColor]
    /// - Returns: Self
    func _colors(_ colors: [UIColor]) -> Self { self.colors = colors.map { $0.cgColor }; return self }
}

// MARK: - CATextLayer (function)
extension CATextLayer {
    
    /// 設定一般文字
    /// - Parameter string: String
    /// - Returns: Self
    func _string(_ string: String) -> Self {
        self.string = NSString(utf8String: string)
        return self
    }
    
    /// 設定字型及文字大小
    /// - Parameter font: UIFont
    /// - Returns: Self
    func _font(_ font: UIFont) -> Self {
        self.font = font
        self.fontSize = font.pointSize
        return self
    }
    
    /// 設定文字清晰度
    /// - Parameter scale: CGFloat
    /// - Returns: Self
    func _contentsScale(_ scale: CGFloat) -> Self {
        self.contentsScale = scale
        return self
    }
}

// MARK: - UIView (function)
extension UIView {
    
    /// 設定frame
    /// - Parameter frame: CGRect
    /// - Returns: Self
    func _frame(_ frame: CGRect) -> Self { self.frame = frame; return self }
}

// MARK: - UILabel (function)
extension UILabel {
    
    /// 設定文字
    /// - Parameter text: String?
    /// - Returns: Self
    func _text(_ text: String?) -> Self { self.text = text; return self }
    
    /// 設定字型
    /// - Parameter font: UIFont
    /// - Returns: Self
    func _font(_ font: UIFont) -> Self { self.font = font; return self }
    
    /// 設定文字顏色
    /// - Parameter textColor: UIColor
    /// - Returns: Self
    func _textColor(_ textColor: UIColor) -> Self { self.textColor = textColor; return self }
    
    /// 設定成合身的尺寸
    /// - Returns: Self
    func _sizeToFit() -> Self { sizeToFit(); return self }
}
