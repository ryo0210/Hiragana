//
//  ViewController.swift
//  Hiragana
//
//  Created by ryo on 2020/04/10.
//  Copyright © 2020 ryo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var convertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextView.delegate = self
    }
    
    @IBAction func convertPressed(_ sender: Any) {
        inputTextView.endEditing(true)
        print(inputTextView.text!)
    }
    

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
}

