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
    // Completions
    
    // Given a prompt, the model will return one or more predicted completions, and can also return the probabilities of alternative tokens at each position.
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
    
    // Edits
    
    // Given a prompt and an instruction, the model will return an edited version of the prompt.
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
    
    // Models
    
    // Lists the currently available models, and provides basic information about each one such as the owner and availability.
    /// - Parameter completion: completion handler
    public func listModels(completion: @escaping (Result<OpenAIAPIModelsResponse, WebServiceError>) -> Void) {
        struct NilParms: Codable {}
        getAPIRequest("/v1/models", configParms: NilParms()) { (result:(Result<OpenAIAPIModelsResponse, WebServiceError>) ) in
            completion(result)
        }
    }
    
    // Retrieves a model instance, providing basic information about the model such as the owner and permissioning.
    /// - Parameters:
    ///   - model: The ID of the model to use for this request
    ///   - completion: completion handler
    public func retrieveModel(_ model: String, completion: @escaping (Result<OpenAIAPIModelResponse, WebServiceError>) -> Void) {
        struct NilParms: Codable { }
        getAPIRequest("/v1/models/\(model)", configParms: NilParms()) { (result:(Result<OpenAIAPIModelResponse, WebServiceError>) ) in
            completion(result)
        }
    }
    
    // Audio
    
    // Transcribes audio into the input language
    /// - Parameters:
    ///   - file: The audio file to transcribe, in one of these formats: mp3, mp4, mpeg, mpga, m4a, wav, or webm
    ///   - prompt: An optional text to guide the model's style or continue a previous audio segment. The prompt should match the audio language
    ///   - language: The language of the input audio. Supplying the input language in ISO-639-1 format will improve accuracy and latency
    ///   - config: query configuration parmeters
    ///   - completion: completion handler
    public func createTranscription(filedata: Data, filename: String, prompt: String?=nil, language: Iso639_1?=nil, config: OpenAIAPIAudioParms, completion: @escaping (Result<OpenAIAPIAudioResponse, WebServiceError>) -> Void) {
        var parms = config
        parms.file = filedata
        parms.prompt = prompt
        parms.language = language?.code

        postAPIRequestMultipartForm("/v1/audio/transcriptions", configParms: parms, filename: filename) { (result:(Result<OpenAIAPIAudioResponse, WebServiceError>) ) in
            completion(result)
        }
    }
    
    // Translates audio into into English
    /// - Parameters:
    ///   - file: The audio file to translate, in one of these formats: mp3, mp4, mpeg, mpga, m4a, wav, or webm
    ///   - prompt: An optional text to guide the model's style or continue a previous audio segment. The prompt should be in English
    ///   - config: query configuration parmeters
    ///   - completion: completion handler
    public func createTranslation(filedata: Data, filename: String, prompt: String?=nil, config: OpenAIAPIAudioParms, completion: @escaping (Result<OpenAIAPIAudioResponse, WebServiceError>) -> Void) {
        var parms = config
        parms.file = filedata
        parms.prompt = prompt

        postAPIRequestMultipartForm("/v1/audio/translations", configParms: parms, filename: filename) { (result:(Result<OpenAIAPIAudioResponse, WebServiceError>) ) in
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
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension OpenAIAPI {
    // Completions
    public func createCompletion(prompt: String, config: OpenAIAPICompletionParms) async throws -> OpenAIAPICompletionResponse {
        return try await withCheckedThrowingContinuation { continuation in
            createCompletion(prompt: prompt, config: config) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    // Edits
    public func createEdit(instruction: String, input: String, config: OpenAIAPIEditParms) async throws -> OpenAIAPIEditResponse {
        return try await withCheckedThrowingContinuation { continuation in
            createEdit(instruction: instruction, input: input, config: config) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    // Models
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
    
    // Audio
    public func createTranscription(file: Data, filename: String, prompt: String?=nil, language: Iso639_1?=nil, config: OpenAIAPIAudioParms) async throws -> OpenAIAPIAudioResponse {
        return try await withCheckedThrowingContinuation { continuation in
            createTranscription(filedata: file, filename: filename, prompt: prompt, language: language, config: config) { result in
                continuation.resume(with: result)
            }
        }
    }
    public func createTranscription(file: Data, filename: String, prompt: String?=nil, config: OpenAIAPIAudioParms) async throws -> OpenAIAPIAudioResponse {
        return try await withCheckedThrowingContinuation { continuation in
            createTranslation(filedata: file, filename: filename, prompt: prompt, config: config) { result in
                continuation.resume(with: result)
            }
        }
    }
}
