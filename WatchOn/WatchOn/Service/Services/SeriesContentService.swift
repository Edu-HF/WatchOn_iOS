//
//  SeriesContentService.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 22/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

class SeriesContentService: BaseService {
    
    // MARK: Series Methods
    func getContentForSeries(resourceIn: APIResource) -> Promise<ResponseSerie>  {
        let params: Parameters = [
            "api_key" : getAPIKey()
        ]
        
        let request = APIRequest.sharedInstance.makeRequest(resourseIn: resourceIn, typeIn: ResponseSerie.self, parametersIn: params, encodingIn: URLEncoding(destination: .queryString), headersIn: buildHeaders())
        return excRequest(requestIn: request)
    }
}
