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

// completion handlers support
extension OpenAIAPI {
    /// Given a prompt, the model will return one or more predicted completions, and can also return the probabilities of alternative tokens at each position.
    /// - Parameters:
    ///   - prompt: prompt description
    ///   - config: query configuration parmeters
    ///   - completion: completion handler
    public func createCompletion(prompt: String, config: OpenAIAPICompletionParms, completion: @escaping (Result<OpenAIAPICompletionResponse, WebServiceError>) -> Void) {
        var parms = config
        parms.prompt = prompt
        
        postAPIRequest("/v1/completions", configParms: parms) { (result:(Result<OpenAIAPICompletionResponse, WebServiceError>) ) in
            completion(result)
        }
    }
    
    /// Given a prompt and an instruction, the model will return an edited version of the prompt.
    /// - Parameters:
    ///   - instruction: The instruction that tells the model how to edit the prompt
    ///   - input: The input text to use as a starting point for the edit
    ///   - config: query configuration parmeters
    ///   - completion: completion handler
    public func createEdit(instruction: String, input: String, config: OpenAIAPIEditParms, completion: @escaping (Result<OpenAIAPIEditResponse, WebServiceError>) -> Void) {
        var parms = config
        parms.instruction = instruction
        parms.input = input

        postAPIRequest("/v1/edits", configParms: parms) { (result:(Result<OpenAIAPIEditResponse, WebServiceError>) ) in
            completion(result)
        }
    }
    
    /// Lists the currently available models, and provides basic information about each one such as the owner and availability.
    /// - Parameter completion: completion handler
    public func listModels(completion: @escaping (Result<OpenAIAPIModelsResponse, WebServiceError>) -> Void) {
        struct NilParms: Codable {}
        getAPIRequest("/v1/models", configParms: NilParms()) { (result:(Result<OpenAIAPIModelsResponse, WebServiceError>) ) in
            completion(result)
        }
    }
    
    /// Retrieves a model instance, providing basic information about the model such as the owner and permissioning.
    /// - Parameters:
    ///   - model: The ID of the model to use for this request
    ///   - completion: completion handler
    public func retrieveModel(_ model: String, completion: @escaping (Result<OpenAIAPIModelResponse, WebServiceError>) -> Void) {
        struct NilParms: Codable { }
        getAPIRequest("/v1/models/\(model)", configParms: NilParms()) { (result:(Result<OpenAIAPIModelResponse, WebServiceError>) ) in
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

// swift concurrency support
extension OpenAIAPI {
    public func createCompletion(prompt: String, config: OpenAIAPICompletionParms) async throws -> OpenAIAPICompletionResponse {
        return try await withCheckedThrowingContinuation { continuation in
            createCompletion(prompt: prompt, config: config) { result in
                continuation.resume(with: result)
            }
        }
    }
    public func createEdit(instruction: String, input: String, config: OpenAIAPIEditParms) async throws -> OpenAIAPIEditResponse {
        return try await withCheckedThrowingContinuation { continuation in
            createEdit(instruction: instruction, input: input, config: config) { result in
                continuation.resume(with: result)
            }
        }
    }
    public func listModels() async throws -> OpenAIAPIModelsResponse {
        return try await withCheckedThrowingContinuation { continuation in
            listModels { result in
                continuation.resume(with: result)
            }
        }
    }
    public func retrieveModel(_ model: String) async throws -> OpenAIAPIModelResponse {
        return try await withCheckedThrowingContinuation { continuation in
            retrieveModel(model) { result in
                continuation.resume(with: result)
            }
        }
    }
}
