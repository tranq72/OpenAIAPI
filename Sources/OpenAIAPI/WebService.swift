//
//  OpenAIAPI
//  WebService.swift
//
//  Created by Nico Tranquilli on 05/02/23.
//

import Foundation

public enum WebServiceError: Error {
    case badUrl
    case noData
    case badResponse
    case noResponse
    case status(code: Int)
    case unknownError(error: Error)
    //case parsing

    /*var code: Int {
        switch self {
        case .badUrl: return -1
        case .noData: return -2
        case .badResponse: return -3
        case .noResponse: return -4
        case .status(_): return -5
        }
    }*/
    var localizedDescription : String {
        switch self {
        case .badUrl: return "provided endpoint url is invalid"
        case .noData: return "response contains no data"
        case .badResponse: return "bad response from server"
        case .noResponse: return "no response from server";
        case .status(let code): return "unexepected \(code) response from server";
        case .unknownError(let error): return "unknown error: \(error.localizedDescription)"
        //case .parsing: return "parsing issues";
        }
    }
    
    init(_ error: Error) {
        self = .unknownError(error: error)
    }
}

public class WebService : NSObject {
    private let session = URLSession.shared
    private let baseURL: URL
    private let secret: String?
    private let organization: String?
    
    init (baseURL:URL, secret: String?, organization: String?=nil) {
        self.baseURL = baseURL
        self.secret = secret
        self.organization = organization
        super.init()
    }
    private func createUrlRequest(_ requestPath:String, method: String) -> URLRequest? {
        var urlComps = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let path = urlComps?.path ?? ""
        urlComps?.path = path + requestPath
        if let url = urlComps?.url {
            var request = URLRequest(url: url)
            request.httpMethod = method
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("gzip", forHTTPHeaderField: "Accept-Encoding")
            if let secret = self.secret {
                request.setValue("Bearer \(secret)", forHTTPHeaderField: "Authorization")
            }
            if let organization = self.organization {
                request.setValue("\(organization)", forHTTPHeaderField: "OpenAI-Organization")
            }
            return request
        }
        return nil
    }
    internal func postAPIRequest<QueryParms: Codable, ResponseType: Codable>(_ requestPath:String, configParms: QueryParms, completion: @escaping (Result<ResponseType, WebServiceError>) -> Void) {
        var request = createUrlRequest(requestPath, method: "POST")
        guard request != nil else {
            return completion(.failure(WebServiceError.badUrl))
        }
        do {
            request!.httpBody = try JSONEncoder().encode(configParms)
            
            let task = session.dataTask(with: request!) { (data, response, error) in
                guard error == nil else {
                    // .mapError(...)
                    let result: Result<ResponseType, WebServiceError> = .failure(WebServiceError(error!))
                    return completion(result)
                }
                guard data != nil else {
                    return completion(.failure(WebServiceError.noData))
                }
                guard response != nil else {
                    return completion(.failure(WebServiceError.noResponse))
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    return completion(.failure(WebServiceError.badResponse))
                }
                let statusCode = httpResponse.statusCode
                guard statusCode == 200 else {
                    return completion(.failure(WebServiceError.status(code: statusCode)))
                }
                do {
                    /*#if DEBUG
                    let str = String(decoding: data!, as: UTF8.self)
                    print("data as string: \(str)")
                    #endif*/
                    
                    let response = try JSONDecoder().decode(ResponseType.self, from: data!)
                    completion(.success(response))
                } catch {
                    let result: Result<ResponseType, WebServiceError> = .failure(WebServiceError(error))
                    return completion(result)
                }
            }
            task.resume()
        } catch {
            let result: Result<ResponseType, WebServiceError> = .failure(WebServiceError(error))
            return completion(result)
        }
    }
    internal func getAPIRequest<QueryParms: Codable, ResponseType: Codable>(_ requestPath:String, configParms: QueryParms, completion: @escaping (Result<ResponseType, WebServiceError>) -> Void) {
        var request = createUrlRequest(requestPath, method: "GET")
        guard request != nil else {
            return completion(.failure(WebServiceError.badUrl))
        }
        if var components = URLComponents(url: request!.url!, resolvingAgainstBaseURL: false) {
            do {
                let jsonData = try JSONEncoder().encode(configParms)
                if let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
                    components.queryItems = jsonDict.map {
                        URLQueryItem(name: $0, value: "\($1)")
                    }
                    request!.url = components.url
                }
            } catch {
                let result: Result<ResponseType, WebServiceError> = .failure(WebServiceError(error))
                return completion(result)
            }
        }
        let task = session.dataTask(with: request!) { (data, response, error) in
            guard error == nil else {
                // .mapError(...)
                let result: Result<ResponseType, WebServiceError> = .failure(WebServiceError(error!))
                return completion(result)
            }
            guard data != nil else {
                return completion(.failure(WebServiceError.noData))
            }
            guard response != nil else {
                return completion(.failure(WebServiceError.noResponse))
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.failure(WebServiceError.badResponse))
            }
            let statusCode = httpResponse.statusCode
            guard statusCode == 200 else {
                return completion(.failure(WebServiceError.status(code: statusCode)))
            }
            do {
                /*#if DEBUG
                let str = String(decoding: data!, as: UTF8.self)
                print("data as string: \(str)")
                #endif*/
                
                let response = try JSONDecoder().decode(ResponseType.self, from: data!)
                completion(.success(response))
            } catch {
                let result: Result<ResponseType, WebServiceError> = .failure(WebServiceError(error))
                return completion(result)
            }
        }
        task.resume()
    }
}
