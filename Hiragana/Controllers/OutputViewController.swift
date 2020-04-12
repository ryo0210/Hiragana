//
//  OutputViewController.swift
//  Hiragana
//
//  Created by ryo on 2020/04/11.
//  Copyright © 2020 ryo. All rights reserved.
//

import UIKit

class OutputViewController: UIViewController {
    
    var hiragana: String?

    @IBOutlet weak var outputTextView: UITextView!
    
    var hiraganaManager = HiraganaManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DispatchQueue.main.async {
//            self.outputTextView.text = self.hiragana
//        }
        outputTextView.text = hiragana
        
    }
    
    @IBAction func reinputPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
