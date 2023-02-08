//
//  OpenAIQueryResponse.swift
//
//  Created by Nico Tranquilli on 05/02/23.
//

import Foundation

public struct OpenAIAPICompletionResponse: Codable {
    public let id: String
    public let object: String
    public let created: TimeInterval
    public let model: String
    public let choices: [Choice]
    public let usage: Usage
}
public struct OpenAIAPIEditResponse: Codable {
    public let object: String
    public let created: TimeInterval
    public let choices: [Choice]
    public let usage: Usage
}

public struct Choice: Codable {
    public let text: String
    public let index: Int
    //public let logprobs: ..
    public let finish_reason: String? // completions
}
public struct Usage: Codable {
    let prompt_tokens: Int
    let completion_tokens: Int
    let total_tokens: Int
}
