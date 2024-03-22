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
    @IBOutlet weak var captchaView: WWCaptchaView!

    private let stringModel: WWCaptchaView.RandomStringModel = .init(
        digits: "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890甲乙丙丁戊己庚辛壬癸",
        length: 3,
        font: .systemFont(ofSize: 56),
        upperBound: 10,
        color: .black
    )
    
    private let lineModel: WWCaptchaView.RandomLineModel = .init(
        count: 5,
        width: 1.0
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captchaView.configure(delegate: self, stringModel: stringModel, lineModel: lineModel)
    }
}

// MARK: - WWCaptchaViewDelegate
extension ViewController: WWCaptchaViewDelegate {
    func captcha(view: WWCaptchaView, string: String?) { captchaLabel.text = string }
}
