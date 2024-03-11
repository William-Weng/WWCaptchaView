//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2024/3/11.
//

import UIKit
import WWPrint
import WWCaptchaView

// MARK: - ViewController
final class ViewController: UIViewController {
    
    @IBOutlet weak var captchaLabel: UILabel!
    @IBOutlet weak var captchaView: MyCaptchaView!

    private let stringModel: WWCaptchaView.RandomStringModel = .init(
        digits: "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890甲乙丙丁戊己庚辛壬癸",
        length: 4,
        font: UIFont.systemFont(ofSize: 56),
        upperBound: 10
    )
    
    private let lineModel: WWCaptchaView.RandomLineModel = .init(
        count: 5,
        width: 1.0
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captchaView.configure(delegate: self, stringModel: stringModel, lineModel: lineModel)
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        captchaView.prepareForInterfaceBuilder()
    }
}

// MARK: - WWCaptchaViewDelegate
extension ViewController: WWCaptchaViewDelegate {
    func captcha(view: WWCaptchaView, string: String?) { captchaLabel.text = string }
}

// MARK: - 可視化WWCaptchaView
final class MyCaptchaView: WWCaptchaView {
    
    override func prepareForInterfaceBuilder() {
        
        let stringModel: WWCaptchaView.RandomStringModel = .init(
            digits: "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890甲乙丙丁戊己庚辛壬癸",
            length: 4,
            font: UIFont.systemFont(ofSize: 56),
            upperBound: 10
        )
        
        let lineModel: WWCaptchaView.RandomLineModel = .init(
            count: 5,
            width: 1.0
        )
        
        self.configure(delegate: nil, stringModel: stringModel, lineModel: lineModel)
    }
}
