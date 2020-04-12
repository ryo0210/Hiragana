//
//  ViewController.swift
//  Hiragana
//
//  Created by ryo on 2020/04/10.
//  Copyright © 2020 ryo. All rights reserved.
// 67adc60cdbf63dfaea3cf13494fa0c3b11e3027a7ad9d878b80430b8ba700bb8

import UIKit

class InputViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var inputTextView: UITextView!
    
    var hiraganaManager = HiraganaManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextView.delegate = self
    }
    
    @IBAction func convertPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToOutput", sender: self)
    }
    

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let words = inputTextView.text {
            hiraganaManager.fetchHiragana(RequestWords: words)
        }
    }
}

