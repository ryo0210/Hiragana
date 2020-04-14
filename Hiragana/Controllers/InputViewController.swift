//
//  ViewController.swift
//  Hiragana
//
//  Created by ryo on 2020/04/10.
//  Copyright © 2020 ryo. All rights reserved.

import UIKit

class InputViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var attentionLabel: UITextView!
    
    var hiraganaManager = HiraganaManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextView.delegate = self
        
        // フォントのバグ対策
        inputTextView.font = UIFont.systemFont(ofSize: 20.0)
    }
    
    // TextView以外の部分をタップするとキーボードが閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func convertPressed(_ sender: UIButton) {
        if inputTextView.text == "" {
            attentionLabel.text = "なにかにゅうりょくしてください。"
        } else {
            inputTextView.endEditing(true)
            performSegue(withIdentifier: "goToOutput", sender: self)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToOutput" {
            let destinationVC = segue.destination as! OutputViewController
            destinationVC.hiragana = inputTextView.text
        }
    }
    @IBAction func trashPressed(_ sender: UIButton) {
        if inputTextView.text == "" {
            attentionLabel.text = "けすもじがありません。"
        } else {
            inputTextView.text = ""
        }
    }
    @IBAction func pastePressed(_ sender: UIButton) {
        inputTextView.text = UIPasteboard.general.string
        if inputTextView.text == "" {
            attentionLabel.text = "ペーストするもじがありません。"
        } else {
            inputTextView.endEditing(true)
            performSegue(withIdentifier: "goToOutput", sender: self)
        }
    }
    
}
