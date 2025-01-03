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
        textColorType: .gradient([.red, .blue])
    )
    
    private let lineModel: WWCaptchaView.RandomLineModel = .init(
        count: 5,
        width: 1.0
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captchaView.configure(delegate: self, stringModel: stringModel, lineModel: lineModel)
        captchaView.redrawCaptcha()
    }
}

// MARK: - WWCaptchaViewDelegate
extension ViewController: WWCaptchaViewDelegate {
    
    func captchaView(_ captchaView: WWCaptchaView, string: String?) { captchaLabel.text = string }
}
