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
    
    //MARK Movies Methods
    func getPopularityMovies() -> Promise<ResponseContent> {
        let params: Parameters = [
            "api_key" : getAPIKey()
        ]
        
        let request = APIRequest.sharedInstance.makeRequest(resourseIn: .getPopularityMovies, typeIn: ResponseContent.self, parametersIn: params, encodingIn: URLEncoding(destination: .queryString), headersIn: buildHeaders())
        return excRequest(requestIn: request)
    }
}
