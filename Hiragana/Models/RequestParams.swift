//
//  RequestParams.swift
//  Hiragana
//
//  Created by ryo on 2020/04/12.
//  Copyright © 2020 ryo. All rights reserved.
//

import Foundation

// リクエストパラメータ
struct RequestParams: Codable {
    let app_id: String,
    output_type: String,
    request_id: String,
    sentence: String
}
