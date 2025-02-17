//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2024/3/11.
//

import UIKit
import WWCaptchaView

// MARK: - ViewController
final class ViewController: UIViewController {
    
    @IBOutlet weak var captchaLabel: UILabel!
    @IBOutlet weak var captchaView: WWCaptchaView!
    
    private let stringModel: WWCaptchaView.RandomStringModel = .init(
        digits: "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890甲乙丙丁戊己庚辛壬癸",
        length: 3,
        font: .systemFont(ofSize: 24),
        upperBound: 36,
        textColorType: .random()
    )
    
    private let lineModel: WWCaptchaView.RandomLineModel = .init(
        count: 5,
        width: 1.0
    )
    
    private var info: [String: CGRect] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captchaView.configure(delegate: self, stringModel: stringModel, lineModel: lineModel)
        captchaView.generate(captchaString: "8庚M")
    }
}

// MARK: - WWCaptchaViewDelegate
extension ViewController: WWCaptchaViewDelegate {
    
    func captchaView(_ captchaView: WWCaptchaView, didTouched touchs: Set<UITouch>) {
        captchaView.generate()
    }
    
    func captchaView(_ captchaView: WWCaptchaView, character: String, at index: Int, frame: CGRect) {
        print("[\(index)] \(character) => \(frame)")
    }
    
    func captchaView(_ captchaView: WWCaptchaView, string: String?) {
        captchaLabel.text = string
    }
}
