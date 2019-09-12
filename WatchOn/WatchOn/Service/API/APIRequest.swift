//
//  APIRequest.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 21/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

enum RequestError: Error {
    case APIError(String)
    case UNError
    case ErrorParsing
}

class APIRequest {
    
    static let sharedInstance = APIRequest()
    
    func makeRequest<T: Codable>(resourseIn: APIResource, typeIn: T.Type, parametersIn: Parameters? = nil, encodingIn: URLEncoding? = nil, headersIn: HTTPHeaders? = nil, mutableURL: URL? = nil) -> Promise<T> {
        let mainURL: URL = (mutableURL != nil) ? mutableURL ?? resourseIn.baseURL.appendingPathComponent(resourseIn.urlPath) : resourseIn.baseURL.appendingPathComponent(resourseIn.urlPath)
        
        var mainRequest: DataRequest!
        
        mainRequest = AF.request(mainURL, method: resourseIn.method, parameters: parametersIn, encoding: encodingIn ?? URLEncoding.default, headers: headersIn)
        
        return Promise { seal in
            mainRequest
                .validate(contentType: ["application/json"])
                .responseJSON(queue: DispatchQueue.global(qos: .userInitiated)) { response in
                    guard let dataResponse = response.data else { return seal.reject(RequestError.UNError) }
                    
                    if let dataResult = self.makeDecode(typeIn, dataResponse) {
                        return seal.fulfill(dataResult)
                    }else if let errorParsing = self.makeDecode(APIError.self, dataResponse) {
                        return seal.reject(RequestError.APIError(errorParsing.error.message))
                    }
                    
                    return seal.reject(RequestError.ErrorParsing)
            }
        }
    }
    
    private func makeDecode<T: Codable>(_ typeIn: T.Type, _ dataIn: Data) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            return try jsonDecoder.decode(typeIn, from: dataIn)
        } catch {
            return makeDecodeWithFragments(dataIn)
        }
    }
    
    private func makeDecodeWithFragments<T: Codable>(_ dataIn: Data) -> T? {
        do {
            return try JSONSerialization.jsonObject(with: dataIn, options: .allowFragments) as? T
        } catch {
            return nil
        }
    }
}
