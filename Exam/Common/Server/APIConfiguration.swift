//
//  APIConfiguration.swift
//  Exam
//
//  Created by Olteanu Andrei on 27/01/2019.
//  Copyright © 2019 Andrei Olteanu. All rights reserved.
//

import Foundation
import RestBird

struct APIConfiguration: NetworkClientConfiguration {
    let baseUrl = "http://localhost:2024"
    let sessionManager: SessionManager = AlamofireSessionManager()
    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()
}
