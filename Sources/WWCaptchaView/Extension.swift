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
