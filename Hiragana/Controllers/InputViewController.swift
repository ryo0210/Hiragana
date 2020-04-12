//
//  ViewController.swift
//  Hiragana
//
//  Created by ryo on 2020/04/10.
//  Copyright © 2020 ryo. All rights reserved.

import UIKit

class InputViewController: UIViewController, UITextViewDelegate, HiraganaManagerDelegate {

    @IBOutlet weak var inputTextView: UITextView!
    
    var hiraganaManager = HiraganaManager()
    var hira: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextView.delegate = self
        hiraganaManager.delegate = self
    }
    
    @IBAction func convertPressed(_ sender: UIButton) {
        print("1-------------")
        inputTextView.endEditing(true)
        if let words = inputTextView.text {
            hiraganaManager.fetchHiragana(RequestWords: words)
        }
        performSegue(withIdentifier: "goToOutput", sender: self)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        print("3-------------")
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("4-------------")
        if let words = inputTextView.text {
            hiraganaManager.fetchHiragana(RequestWords: words)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToOutput" {
            let destinationVC = segue.destination as! OutputViewController
            if hira != nil {
                destinationVC.hiragana = hira
            }
        }
    }
    
    func didUpdateWords(words: String) {
//        DispatchQueue.main.async {
//            self.inputTextView.text = words
//        }
        hira = words
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

