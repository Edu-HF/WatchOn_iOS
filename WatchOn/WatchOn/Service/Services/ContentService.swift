//
//  ContentService.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 21/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

class ContentService: BaseService {
    
    //MARK: Movies Methods
    func getContentForMovies(resourceIn: APIResource) -> Promise<ResponseContent> {
        let params: Parameters = [
            "api_key" : getAPIKey()
        ]
        
        let request = APIRequest.sharedInstance.makeRequest(resourseIn: resourceIn, typeIn: ResponseContent.self, parametersIn: params, encodingIn: URLEncoding(destination: .queryString), headersIn: buildHeaders())
        return excRequest(requestIn: request)
    }
    
    func getGenres() -> Promise<ResponseGenre> {
        let params: Parameters = [
            "api_key" : getAPIKey()
        ]
        
        let request = APIRequest.sharedInstance.makeRequest(resourseIn: .getGenres, typeIn: ResponseGenre.self, parametersIn: params, encodingIn: URLEncoding(destination: .queryString), headersIn: buildHeaders())
        return excRequest(requestIn: request)
    }
    
    func getCast(contentIn: Content) -> Promise<ResponseCast> {
        let params: Parameters = [
            "api_key" : getAPIKey()
        ]
        
        let castMainURL = APIResource.getCast.baseURL.appendingPathComponent(APIResource.getCast.urlPath + "\(contentIn.contentID)/credits")
        
        let request = APIRequest.sharedInstance.makeRequest(resourseIn: APIResource.getCast, typeIn: ResponseCast.self, parametersIn: params, encodingIn: URLEncoding(destination: .queryString), headersIn: buildHeaders(), mutableURL: castMainURL)
        return excRequest(requestIn: request)
    }
    
    func getContentMedia(contentIn: Content) -> Promise<ResponseMediaData> {
        let params: Parameters = [
            "api_key" : getAPIKey()
        ]
        
        let mediaMainURL = APIResource.getMedia.baseURL.appendingPathComponent(APIResource.getMedia.urlPath + "\(contentIn.contentID)/videos")
        
        let request = APIRequest.sharedInstance.makeRequest(resourseIn: APIResource.getCast, typeIn: ResponseMediaData.self, parametersIn: params, encodingIn: URLEncoding(destination: .queryString), headersIn: buildHeaders(), mutableURL: mediaMainURL)
        return excRequest(requestIn: request)
    }
}
