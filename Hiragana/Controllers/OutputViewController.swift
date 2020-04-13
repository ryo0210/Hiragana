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
    
    var hiraganaManager = HiraganaManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hiraganaManager.delegate = self
        hiraganaManager.fetchHiragana(RequestWords: hiragana!)
    }
    
    @IBAction func reinputPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
