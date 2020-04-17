//
//  HiragaManager.swift
//  Hiragana
//
//  Created by ryo on 2020/04/11.
//  Copyright © 2020 ryo. All rights reserved.
//

import Foundation

protocol HiraganaManagerDelegate {
    func didUpdateWords(words: String)
    func didFailWithError(error: Error)
}

struct HiraganaManager {
    
    var delegate: HiraganaManagerDelegate?
    
    let hiraganaURL = "https://labs.goo.ne.jp/api/hiragana"

    let app_id = "api"
    
    func fetchHiragana(RequestWords: String) {
        let url = URL(string: hiraganaURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let requestParams = RequestParams(
            app_id: app_id,
            output_type: "hiragana",
            request_id: "record003",
            sentence: RequestWords
        )
        
        guard let uploadData = try? JSONEncoder().encode(requestParams) else {
            print("json generation failed")
            return
        }
        request.httpBody = uploadData

        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { (data, response, error) in
            if error != nil {
                self.delegate?.didFailWithError(error: error!)
                return
            }
            if let safeData = data {
                if let hiragana = self.parseJSON(safeData) {
                    self.delegate?.didUpdateWords(words: hiragana)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(_ hiraganaData: Data) -> String? {
        let decoder = JSONDecoder()
        
        // プロパティの名前をsnake_caseからlowerCamelCaseにする。
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decodeData = try decoder.decode(HiraganaData.self, from: hiraganaData)
            let responseWords = decodeData.converted
            return responseWords
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
