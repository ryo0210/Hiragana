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

    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var copyLabel: UILabel!
    
    var hiraganaManager = HiraganaManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hiraganaManager.delegate = self
        hiraganaManager.fetchHiragana(RequestWords: hiragana!)
    }
    
    @IBAction func reinputPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func copyPressed(_ sender: UIButton) {
        UIPasteboard.general.string = outputTextView.text
        copyLabel.text = "コピーしました。"
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.copyLabel.text = ""
        }
    }
    
    
    func didUpdateWords(words: String) {
        DispatchQueue.main.async {
            self.outputTextView.text = words
        }
    }
        
    func didFailWithError(error: Error) {
        print(error)
    }
}
