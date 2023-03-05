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
    case apiError(msg: String)
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
        case .apiError(let msg): return msg
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
    private func createUrlRequest(_ requestPath:String, method: String, jsonRequest: Bool=true) -> URLRequest? {
        var urlComps = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let path = urlComps?.path ?? ""
        urlComps?.path = path + requestPath
        if let url = urlComps?.url {
            var request = URLRequest(url: url)
            request.httpMethod = method
            if jsonRequest { // json
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            } else { // multipart/form-data
                request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
            }
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
            #if DEBUG
            print(String(data: request!.httpBody!, encoding: .utf8)!)
            #endif
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
                    //return completion(.failure(WebServiceError.status(code: statusCode)))

                    /*
                     error example
                     "error": {
                         "message": "Incorrect API key provided: secret. You can find your API key at https://platform.openai.com/account/api-keys.",
                         "type": "invalid_request_error",
                         "param": null,
                         "code": "invalid_api_key"
                     }
                     */
                    do {
                        let errorResponse = try JSONDecoder().decode(OpenAIAPIErrorResponse.self, from: data!)
                        return completion(.failure(WebServiceError.apiError(msg:errorResponse.error.message)))
                    } catch {
                        #if DEBUG
                        print(String(data: data!, encoding: .utf8)!)
                        print("error = \(error.localizedDescription)")
                        #endif
                        return completion(.failure(WebServiceError.status(code: statusCode)))
                    }
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
                do {
                    let errorResponse = try JSONDecoder().decode(OpenAIAPIErrorResponse.self, from: data!)
                    return completion(.failure(WebServiceError.apiError(msg:errorResponse.error.message)))
                } catch {
                    /*#if DEBUG
                    print(String(data: data!, encoding: .utf8)!)
                    print("error = \(error.localizedDescription)")
                    #endif*/
                    return completion(.failure(WebServiceError.status(code: statusCode)))
                }
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
    
    // likely to big to hold in memory, rewrite using URLSessionUploadTask / backgrouns sessions
    internal func postAPIRequestMultipartForm(_ requestPath:String, configParms: OpenAIAPIAudioParms, filename: String, completion: @escaping (Result<OpenAIAPIAudioResponse, WebServiceError>) -> Void) {
        var request = createUrlRequest(requestPath, method: "POST", jsonRequest: false)
        guard request != nil else {
            return completion(.failure(WebServiceError.badUrl))
        }

        //request!.httpBody = try JSONEncoder().encode(configParms)
        let boundary = UUID().uuidString
        request!.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var formData = Data()
        
        let mirror = Mirror(reflecting: configParms)
        for child in mirror.children {
            if let propertyName = child.label {
                if (type(of: child.value) == Optional<Data>.self || type(of: child.value) == Data.self), let value = child.value as? Data {
                    formData.append("--\(boundary)\r\n".data(using: .utf8)!)
                    formData.append("Content-Disposition: form-data; name=\"\(propertyName)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
                    //formData.append("Content-Type: audio/mp4\r\n\r\n".data(using: .utf8)!)
                    formData.append("\r\n".data(using: .utf8)!)
                    formData.append(value)
                    formData.append("\r\n".data(using: .utf8)!)
                    continue
                }
                if (type(of: child.value) == Optional<String>.self || type(of: child.value) == String.self), let value = child.value as? String {
                    formData.append("--\(boundary)\r\n".data(using: .utf8)!)
                    formData.append("Content-Disposition: form-data; name=\"\(propertyName)\"\r\n\r\n".data(using: .utf8)!)
                    formData.append(value.data(using: .utf8)!)
                    formData.append("\r\n".data(using: .utf8)!)
                    continue
                }
                if (type(of: child.value) == Optional<Float>.self || type(of: child.value) == Float.self), let value = child.value as? Float {
                    formData.append("--\(boundary)\r\n".data(using: .utf8)!)
                    formData.append("Content-Disposition: form-data; name=\"\(propertyName)\"\r\n\r\n".data(using: .utf8)!)
                    formData.append("\(value)".data(using: .utf8)!)
                    formData.append("\r\n".data(using: .utf8)!)
                    continue
                }
                if (type(of: child.value) == Optional<Int>.self || type(of: child.value) == Int.self), let value = child.value as? Int {
                    formData.append("--\(boundary)\r\n".data(using: .utf8)!)
                    formData.append("Content-Disposition: form-data; name=\"\(propertyName)\"\r\n\r\n".data(using: .utf8)!)
                    formData.append("\(value)".data(using: .utf8)!)
                    formData.append("\r\n".data(using: .utf8)!)
                    continue
                }
            }
        }

        formData.append("--\(boundary)--\r\n".data(using: .utf8)!) // Add the closing boundary
        
        //print(String(decoding: formData, as: UTF8.self))
        request!.httpBody = formData
                
        let task = session.dataTask(with: request!) { (data, response, error) in
            guard error == nil else {
                // .mapError(...)
                let result: Result<OpenAIAPIAudioResponse, WebServiceError> = .failure(WebServiceError(error!))
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
                //return completion(.failure(WebServiceError.status(code: statusCode)))
                
                /*
                 error example
                 "error": {
                 "message": "Incorrect API key provided: secret. You can find your API key at https://platform.openai.com/account/api-keys.",
                 "type": "invalid_request_error",
                 "param": null,
                 "code": "invalid_api_key"
                 }
                 */
                do {
                    let errorResponse = try JSONDecoder().decode(OpenAIAPIErrorResponse.self, from: data!)
                    return completion(.failure(WebServiceError.apiError(msg:errorResponse.error.message)))
                } catch {
#if DEBUG
                    print(String(data: data!, encoding: .utf8)!)
                    print("error = \(error.localizedDescription)")
#endif
                    return completion(.failure(WebServiceError.status(code: statusCode)))
                }
            }
            do {
                /*#if DEBUG
                 let str = String(decoding: data!, as: UTF8.self)
                 print("data as string: \(str)")
                 #endif*/
                
                let response = try JSONDecoder().decode(OpenAIAPIAudioResponse.self, from: data!)
                completion(.success(response))
            } catch {
                let result: Result<OpenAIAPIAudioResponse, WebServiceError> = .failure(WebServiceError(error))
                return completion(result)
            }
        }
        task.resume()
    }
}
