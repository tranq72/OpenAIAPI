//
//  OpenAIAPIConfig.swift
//
//  Created by Nico Tranquilli on 05/02/23.
//

import Foundation

public struct OpenAIAPIConfig {
    fileprivate(set) var secret: String?
    let baseURL: URL
    let organization: String?
    
    /// ideally, credentials should NOT be exposed in your code, hardcoded or not it doesn't matter
    /// set <endpoint> to your backend/reverse-proxy and don't use your real OpenAI API secret in your client app
    /// openai endpoint fallback is just for development and testing
    init (secret: String?=nil, endpoint: String?=nil, organization: String?=nil) {
        self.secret = secret
        self.baseURL = URL(string: endpoint ?? "https://api.openai.com")!
        self.organization = organization
    }
}

