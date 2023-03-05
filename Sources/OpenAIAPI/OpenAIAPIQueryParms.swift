//
//  OpenAIAPIQueryParms.swift
//
//  Created by Nico Tranquilli on 05/02/23.
//

import Foundation

// Completions
public struct OpenAIAPICompletionParms : Codable {
    var model: String = OpenAIAPIModel.text_davinci_003.name
    var prompt: String = "<|endoftext|>"
    //var instruction: String = "do nothing"
    //var input: String = ""

    var suffix: String?
    var max_tokens: Int = 16

    var temperature: Float = 1
    var top_p: Float = 1
    var n: Int = 1
    
    var echo: Bool = false
    var stop: String?
    var presence_penalty: Float = 0
    var frequency_penalty: Float = 0

    var user: String?
}

// Edits
public struct OpenAIAPIEditParms : Codable {
    var model: String = OpenAIAPIModel.text_davinci_edit_001.name

    var input: String = ""
    var instruction: String = "do nothing"
    
    var n: Int = 1
    var temperature: Float = 1
    var top_p: Float = 1
   
    var user: String?
}

// Audio
public struct OpenAIAPIAudioParms : Codable {
    var file: Data?
    var model: String = OpenAIAPIModel.whisper_1.name
    var prompt: String?
    var response_format: String = OpenAIAPIResponseFormat.json.name
    
    var temperature: Float = 0
    var language: String? // Iso639_1?.code - transcriptions only
    
    var user: String?
}

/*
extension OpenAIQueryConfig {
    init(defaults: String) {
        let data = defaults.data(using: .utf8)!
        self = try! JSONDecoder().decode(Self.self, from: data)
    }
}
*/
