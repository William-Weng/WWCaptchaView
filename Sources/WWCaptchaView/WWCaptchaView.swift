//
//  WWCaptchaView.swift
//  WWCaptchaView
//
//  Created by William.Weng on 2024/3/11.
//

import UIKit

// MARK: - WWCaptchaViewDelegate
public protocol WWCaptchaViewDelegate: AnyObject {
    
    /// 取得驗證碼
    /// - Parameters:
    ///   - view: WWCaptchaView
    ///   - string: 驗證碼
    func captcha(view: WWCaptchaView, string: String?)
}

// MARK: - 小工具
open class WWCaptchaView: UIView {
    
    private var stringModel: RandomStringModel?     // 跟文字相關的設定值
    private var lineModel: RandomLineModel?         // 跟干擾線相關的設定值
    private var captchaString: String?              // 驗證碼
    
    private weak var delegate: WWCaptchaViewDelegate?
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        redrawCaptcha()
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        redraw(rect: rect)
    }
}

// MARK: - 公開函式
public extension WWCaptchaView {
    
    /// [設定初始值](https://www.jianshu.com/p/209f08f369a1)
    /// - Parameters:
    ///   - delegate: WWCaptchaViewDelegate?
    ///   - stringModel: RandomStringModel
    ///   - lineModel: RandomLineModel
    func configure(delegate: WWCaptchaViewDelegate? = nil, stringModel: RandomStringModel = .init(digits: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890", length: 4, font: UIFont.systemFont(ofSize: 18), upperBound: 5), lineModel: RandomLineModel = .init(count: 6, width: 1.0)) {
        
        self.stringModel = stringModel
        self.lineModel = lineModel
        self.delegate = delegate
        
        captchaString = randomString(stringModel: stringModel)
        backgroundColor = UIColor._random()
    }
    
    /// [重新繪製驗證碼](https://zh.wikipedia.org/zh-tw/验证码)
    func redrawCaptcha() {
        self.captchaString = randomString(stringModel: stringModel)
        self.setNeedsDisplay()
    }
    
    /// 重新繪製自訂驗證碼
    /// - Parameter captchaString: 自訂驗證碼
    func redrawCaptchaString(_ captchaString: String?) {
        self.captchaString = captchaString
        self.setNeedsDisplay()
    }
}

// MARK: - 小工具
private extension WWCaptchaView {
    
    /// 重新繪製
    /// - Parameters:
    ///   - rect: CGRect
    func redraw(rect: CGRect) {
        
        guard let stringModel = stringModel,
              let lineModel = lineModel
        else {
            return
        }
        
        backgroundColor = UIColor._random()
        
        drawString(captchaString, rect: rect, stringModel: stringModel)
        drawInterferenceLine(rect: rect, lineModel: lineModel)
    }
    
    /// 繪製文字
    /// - Parameters:
    ///   - string: String
    ///   - rect: CGRect
    ///   - stringModel: RandomStringModel
    func drawString(_ string: String?, rect: CGRect, stringModel: RandomStringModel) {
        
        defer { delegate?.captcha(view: self, string: string) }
        
        guard let string = string else { return }
        
        let estimateCharSize = estimateCharacterSize("龘", font: stringModel.font)
        let charSize = characterSize(string: string, rect: rect, estimateCharacterSize: estimateCharSize)
        
        for index in 0..<string.count {
            
            let point = characterPoint(with: index, totalCount: string.count, rect: rect, size: charSize)
            let text = string as NSString
            let char = text.character(at: index)
            let character = NSString(format: "%C", char)
            
            character.draw(at: point, withAttributes: [NSAttributedString.Key.font : randomFont(stringModel: stringModel)])
        }
    }
    
    /// 繪製干擾線
    /// - Parameters:
    ///   - rect: CGRect
    ///   - lineModel: RandomLineModel
    func drawInterferenceLine(rect: CGRect, lineModel: RandomLineModel) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
                
        for _ in 0..<lineModel.count {
                       
            let startPoint = randomPoint(rect.size)
            let endPoint = randomPoint(rect.size)

            context.move(to: startPoint)
            context.addLine(to: endPoint)
            
            context.setStrokeColor(UIColor._random().cgColor)
            context.setLineWidth(lineModel.width)
            context.strokePath()
        }
    }
}

// MARK: - 小工具
private extension WWCaptchaView {
        
    /// 隨機產生的驗證碼
    /// - Parameter stringModel: RandomStringModel?
    /// - Returns: String?
    func randomString(stringModel: RandomStringModel?) -> String? {
        
        guard let stringModel = stringModel else { return nil }
        
        let randomString = String._random(length: stringModel.length, by: stringModel.digits)
        return randomString
    }
    
    /// 計算每個字元的位置
    /// - Parameters:
    ///   - index: Int
    ///   - totalCount: Int
    ///   - rect: CGRect
    ///   - size: CGSize
    /// - Returns: CGPoint
    func characterPoint(with index: Int, totalCount: Int, rect: CGRect, size: CGSize) -> CGPoint {
        
        let randomSize = randomSize(size)
        var point: CGPoint = .zero
        
        point.x = randomSize.width + rect.size.width / CGFloat(totalCount) * CGFloat(index)
        point.y = randomSize.height
        
        return point
    }
        
    /// 計算每個字元顯示寬度 / 高度的位置
    /// - Parameter rect: CGRect
    func characterSize(string: String, rect: CGRect, estimateCharacterSize: CGSize) -> CGSize {
        
        let width = (rect.size.width / CGFloat(string.count)) - CGFloat(estimateCharacterSize.width)
        let height = rect.size.height - estimateCharacterSize.height
        
        return CGSize(width: width, height: height)
    }
    
    /// 大約估計一個字元的大小
    /// - Parameters:
    ///   - character: Character
    ///   - font: UIFont
    /// - Returns: CGSize
    func estimateCharacterSize(_ character: Character, font: UIFont) -> CGSize {
        let size = NSString(string: "\(character)").size(withAttributes: [NSAttributedString.Key.font : font])
        return size
    }
    
    /// 隨機尺寸大小
    /// - Parameter maxSize: CGSize
    /// - Returns: CGSize
    func randomSize(_ maxSize: CGSize) -> CGSize {
        
        let width = Int._random(upperBound: Int(maxSize.width))
        let height = Int._random(upperBound: Int(maxSize.height))
        
        return CGSize(width: width, height: height)
    }
    
    /// 隨機位置大小
    /// - Parameter maxSize: CGSize
    /// - Returns: CGSize
    func randomPoint(_ maxSize: CGSize) -> CGPoint {
        
        let width = Int._random(upperBound: Int(maxSize.width))
        let height = Int._random(upperBound: Int(maxSize.height))
        
        return CGPoint(x: width, y: height)
    }
    
    /// 隨機字型文字大小
    /// - Parameter stringModel: RandomStringModel
    /// - Returns: UIFont
    func randomFont(stringModel: RandomStringModel) -> UIFont {
        let size = CGFloat(Int._random(upperBound: stringModel.upperBound)) + stringModel.font.pointSize
        return stringModel.font.withSize(size)
    }
}
