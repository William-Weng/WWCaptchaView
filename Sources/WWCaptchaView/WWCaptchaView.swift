//
//  WWCaptchaView.swift
//  WWCaptchaView
//
//  Created by William.Weng on 2024/3/11.
//

import UIKit

// MARK: - 小工具
@IBDesignable
open class WWCaptchaView: UIView {
    
    private var stringModel: RandomStringModel?     // 跟文字相關的設定值
    private var lineModel: RandomLineModel?         // 跟干擾線相關的設定值
    private var captchaString: String?              // 驗證碼
    private var captchaLabels: [UILabel] = []       // 驗證碼Label
    
    private weak var delegate: WWCaptchaViewDelegate?
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        delegate?.captchaView(self, didTouched: touches)
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        redraw(rect: rect)
    }
    
    deinit {
        delegate = nil
    }
}

// MARK: - 公開函式
public extension WWCaptchaView {
    
    /// [設定初始值](https://www.jianshu.com/p/209f08f369a1)
    /// - Parameters:
    ///   - delegate: WWCaptchaViewDelegate?
    ///   - stringModel: RandomStringModel
    ///   - lineModel: RandomLineModel
    func configure(delegate: WWCaptchaViewDelegate? = nil, stringModel: RandomStringModel = .init(digits: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890", length: 4, font: UIFont.systemFont(ofSize: 18), upperBound: 5, textColorType: .mono(.black, false)), lineModel: RandomLineModel = .init(count: 6, width: 1.0)) {
        
        self.stringModel = stringModel
        self.lineModel = lineModel
        self.delegate = delegate
    }
    
    /// [重新繪製驗證碼](https://zh.wikipedia.org/zh-tw/验证码)
    /// - Parameter captchaString: 自訂的驗證碼
    func generate(captchaString: String? = nil) {
        
        defer { setNeedsDisplay() }
        
        if captchaString == nil { self.captchaString = randomString(stringModel: stringModel); return }
        self.captchaString = captchaString
    }
}

// MARK: - 小工具
private extension WWCaptchaView {
    
    /// 重新繪製
    /// - Parameters:
    ///   - rect: 整個View的位置大小
    func redraw(rect: CGRect) {
        
        guard let stringModel = stringModel,
              let lineModel = lineModel
        else {
            return
        }
        
        drawString(captchaString, rect: rect, stringModel: stringModel)
        drawInterferenceLine(rect: rect, lineModel: lineModel)
    }
    
    /// 繪製文字
    /// - Parameters:
    ///   - string: String
    ///   - rect: 整個View的位置大小
    ///   - stringModel: 跟文字相關的設定值
    func drawString(_ string: String?, rect: CGRect, stringModel: RandomStringModel) {
        
        defer { delegate?.captchaView(self, string: string) }
        
        guard let string = string else { return }
        
        captchaLabels.forEach { $0.removeFromSuperview() }
        
        for index in 0..<string.count {
            
            let text = string as NSString
            let char = text.character(at: index)
            let character = NSString(format: "%C", char)
            let font = randomFont(stringModel: stringModel)
            let estimateCharSize = font._estimateCharacterSize()
            let charSize = characterSize(string: string, rect: rect, estimateCharacterSize: estimateCharSize)
            let point = characterPoint(with: index, totalCount: string.count, rect: rect, size: charSize)
            let frame = CGRect(origin: point, size: charSize)
            
            switch stringModel.textColorType {
            case .mono(let color, let isTransform): monoColorTextSetting(character, frame: frame, font: font, textColor: color, isTransform: isTransform)
            case .random(let isTransform): monoColorTextSetting(character, frame: frame, font: font, textColor: UIColor._random(), isTransform: isTransform)
            case .gradient(let colors, let isTransform): gradientColorTextSetting(character, frame: frame, font: font, colors: colors, isTransform: isTransform)
            }
            
            delegate?.captchaView(self, character: character as String, at: index, frame: frame)
        }
    }
    
    /// 單一顏色的文字處理
    /// - Parameters:
    ///   - character: NSString
    ///   - frame: CGRect
    ///   - font: UIFont
    ///   - textColor: UIColor
    ///   - isTransform: Bool
    func monoColorTextSetting(_ character: NSString, frame: CGRect, font: UIFont, textColor: UIColor, isTransform: Bool) {
        
        if !isTransform { drawCharacter(character, at: frame.origin, font: font, textColor: textColor); return }
        
        let label = characterLabel(character, frame: frame, font: font, textColor: textColor, isTransform: isTransform)
        captchaLabels.append(label)
        layer.addSublayer(label.layer)
    }
    
    /// 漸層顏色的文字處理
    /// - Parameters:
    ///   - character: NSString
    ///   - frame: CGRect
    ///   - font: UIFont
    ///   - colors: [UIColor]
    ///   - isTransform: Bool
    func gradientColorTextSetting(_ character: NSString, frame: CGRect, font: UIFont, colors: [UIColor], isTransform: Bool) {
        
        let label = characterGradientLabel(character, frame: frame, font: font, colors: colors, isTransform: isTransform)
        captchaLabels.append(label)
        layer.addSublayer(label.layer)
    }
    
    /// 繪出單色文字
    /// - Parameters:
    ///   - character: NSString
    ///   - point: CGPoint
    ///   - font: UIFont
    ///   - textColor: UIColor
    func drawCharacter(_ character: NSString, at point: CGPoint, font: UIFont, textColor: UIColor) {
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor,
        ]
        
        character.draw(at: point, withAttributes: attributes)
    }
    
    /// 產生文字Label (Z軸旋轉)
    /// - Parameters:
    ///   - character: NSString
    ///   - frame: CGRect
    ///   - font: UIFont
    ///   - textColor: UIColor
    ///   - isTransform: Bool
    /// - Returns: UILabel
    func characterLabel(_ character: NSString, frame: CGRect, font: UIFont, textColor: UIColor, isTransform: Bool) -> UILabel {
        
        let label = UILabel()
        let string = String(character)
        let randomAngle = Double.pi * Double(Int.random(in: -50...50)) / 100.0
        
        _ = label._frame(frame)._text(string)._font(font)._textColor(textColor)._sizeToFit()
        if isTransform { label.layer.transform = CATransform3DMakeRotation(randomAngle, 0, 0, 1) }
        
        return label
    }
    
    /// 產生漸層顏色的文字Label (Z軸旋轉)
    /// - Parameters:
    ///   - character: NSString
    ///   - frame: CGRect
    ///   - font: UIFont
    ///   - colors: [UIColor]
    ///   - isTransform: Bool
    /// - Returns: UILabel
    func characterGradientLabel(_ character: NSString, frame: CGRect, font: UIFont, colors: [UIColor], isTransform: Bool) -> UILabel {
        
        let label = characterLabel(character, frame: frame, font: font, textColor: .black, isTransform: isTransform)
        let gradientLayer = CAGradientLayer()
        let textMaskLayer = CATextLayer()
        let string = String(character)
        let randomAngle = Double.pi * Double(Int.random(in: -50...50)) / 100.0
        
        _ = gradientLayer._frame(label.bounds)._colors(colors)._point(from: CGPoint(x: 0, y: 0.5), to: CGPoint(x: 1, y: 0.5))
        _ = textMaskLayer._frame(label.bounds)._string(string)._font(font)
        
        gradientLayer.mask = textMaskLayer
        label.layer.addSublayer(gradientLayer)
        
        if isTransform { label.layer.transform = CATransform3DMakeRotation(randomAngle, 0, 0, 1) }
        
        return label
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
        let x = randomSize.width + (rect.size.width / CGFloat(totalCount) * CGFloat(index))
        let y = randomSize.height
                
        return CGPoint(x: x, y: y)
    }
    
    /// 計算平均每個字元能放置的大小
    /// - Parameters:
    ///   - string: String
    ///   - rect: 畫面的位置大小
    ///   - estimateCharacterSize: 估計單一字元的大小
    /// - Returns: CGSize
    func characterSize(string: String, rect: CGRect, estimateCharacterSize: CGSize) -> CGSize {
        
        let width = (rect.size.width / CGFloat(string.count)) - CGFloat(estimateCharacterSize.width)
        let height = rect.size.height - estimateCharacterSize.height
        
        return CGSize(width: width, height: height)
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
        return stringModel.font.withSize(CGFloat(size))
    }
}
