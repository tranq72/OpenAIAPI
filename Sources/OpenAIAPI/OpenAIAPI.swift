//
//  OpenAIAPI.swift
//
//  Created by Nico Tranquilli on 05/02/23.
//

import Foundation

public class OpenAIAPI : WebService { // OpenAI Service
    let config : OpenAIAPIConfig

    init(_ config: OpenAIAPIConfig) {
        self.config = config
        super.init(baseURL: config.baseURL, secret: config.secret)
    }
}

extension OpenAIAPI {
    /// Given a prompt, the model will return one or more predicted completions, and can also return the probabilities of alternative tokens at each position.
    public func createCompletion(prompt: String, config: OpenAIAPICompletionParms, completion: @escaping (Result<OpenAIAPICompletionResponse, WebServiceError>) -> Void) {
        var parms = config
        parms.prompt = prompt
        
        // any Error
        postAPIRequest("/v1/completions", configParms: parms) { (result:(Result<OpenAIAPICompletionResponse, WebServiceError>) ) in
            completion(result)
        }
    }
    
    public func createEdit(instruction: String, input: String, config: OpenAIAPIEditParms, completion: @escaping (Result<OpenAIAPIEditResponse, WebServiceError>) -> Void) {

        var parms = config
        parms.instruction = instruction
        parms.input = input

        postAPIRequest("/v1/edits", configParms: parms) { (result:(Result<OpenAIAPIEditResponse, WebServiceError>) ) in
            completion(result)
        }
    }
    
    /*
    public func createImage() {
        
    }
    
    public func createEmbeddings() {
        
    }
    
    public func createModerations() {
        
    }
     */
}
