//
//  OutputViewController.swift
//  Hiragana
//
//  Created by ryo on 2020/04/11.
//  Copyright © 2020 ryo. All rights reserved.
//

import UIKit

class OutputViewController: UIViewController, HiraganaManagerDelegate {
    
    var hiragana: String?
    weak var timer: Timer!

    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var copyLabel: UILabel!
    @IBOutlet weak var outShadowView: UIView!
    
    var hiraganaManager = HiraganaManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hiraganaManager.delegate = self
        hiraganaManager.fetchHiragana(RequestWords: hiragana!)
        
        // 編集を不可にする
        outputTextView.isEditable = false
        
        outShadowView.layer.cornerRadius = 10
        outShadowView.layer.shadowColor = UIColor.black.cgColor
        outShadowView.layer.shadowOffset = .zero
        outShadowView.layer.shadowOpacity = 0.4
        outShadowView.layer.shadowRadius = 4
    }
    
    @IBAction func reinputPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func copyPressed(_ sender: UIButton) {
        UIPasteboard.general.string = outputTextView.text
        copyLabel.text = "コピーしました。"
        copyTextDisplay()
    }
    
    
    func didUpdateWords(words: String) {
        DispatchQueue.main.async {
            self.outputTextView.text = words
        }
    }
        
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.copyLabel.text = "エラーがでました。"
        }
    }
    
    func copyTextDisplay() {
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(
                timeInterval: 3,
                target: self,
                selector: #selector(resetText),
                userInfo: nil,
                repeats: false
            )
        } else {
            self.timer.invalidate()
            self.timer = nil
            self.timer = Timer.scheduledTimer(
                timeInterval: 3,
                target: self,
                selector: #selector(resetText),
                userInfo: nil,
                repeats: false
            )
        }
    }
    
    @objc func resetText() {
        self.copyLabel.text = ""
    }
}
