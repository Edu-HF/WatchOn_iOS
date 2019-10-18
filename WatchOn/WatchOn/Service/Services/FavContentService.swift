//
//  FavContentService.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 15/10/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

class FavContentService: BaseService {
    
    func getSerieDetail(serieIDIn: Int) -> Promise<SerieContent> {
        let params: Parameters = [
            "api_key" : getAPIKey()
        ]
        
        let detailMainURL = APIResource.getCast.baseURL.appendingPathComponent(APIResource.getSerieDetail.urlPath + "\(serieIDIn)")
        
        let request = APIRequest.sharedInstance.makeRequest(resourseIn: APIResource.getSerieDetail, typeIn: SerieContent.self, parametersIn: params, encodingIn: URLEncoding(destination: .queryString), headersIn: buildHeaders(), mutableURL: detailMainURL)
        return excRequest(requestIn: request)
    }
}
