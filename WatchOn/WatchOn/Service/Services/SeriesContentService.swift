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
    
    func getSerieDetail(serieContentIn: SerieContent) -> Promise<SerieContent> {
        let params: Parameters = [
            "api_key" : getAPIKey()
        ]
        
        let serieID = serieContentIn.serieID ?? 0
        let detailMainURL = APIResource.getCast.baseURL.appendingPathComponent(APIResource.getSerieDetail.urlPath + "\(serieID)")
        
        let request = APIRequest.sharedInstance.makeRequest(resourseIn: APIResource.getSerieDetail, typeIn: SerieContent.self, parametersIn: params, encodingIn: URLEncoding(destination: .queryString), headersIn: buildHeaders(), mutableURL: detailMainURL)
        return excRequest(requestIn: request)
    }
    
    func getSerieEpisodesBySeason(serieSeasonIn: Season) -> Promise<ResponseEpisode> {
        let params: Parameters = [
            "api_key" : getAPIKey()
        ]
        
        let seasonID = serieSeasonIn.sID ?? 0
        let seasonNum = serieSeasonIn.sNumber ?? 0
        let detailMainURL = APIResource.getCast.baseURL.appendingPathComponent(APIResource.getSerieEpisodes.urlPath + "\(seasonID)/season/\(seasonNum)")
        
        let request = APIRequest.sharedInstance.makeRequest(resourseIn: APIResource.getSerieEpisodes, typeIn: ResponseEpisode.self, parametersIn: params, encodingIn: URLEncoding(destination: .queryString), headersIn: buildHeaders(), mutableURL: detailMainURL)
        return excRequest(requestIn: request)
    }
    
    func getContentMedia(episodeIn: Episode) -> Promise<ResponseMediaData> {
        let params: Parameters = [
            "api_key" : getAPIKey()
        ]
        
        let eID = episodeIn.eID ?? 0
        print("EPISODE ID: ", eID)
        let mediaMainURL = APIResource.getMedia.baseURL.appendingPathComponent(APIResource.getSerieMedia.urlPath + "\(eID)/videos")
        
        let request = APIRequest.sharedInstance.makeRequest(resourseIn: APIResource.getSerieMedia, typeIn: ResponseMediaData.self, parametersIn: params, encodingIn: URLEncoding(destination: .queryString), headersIn: buildHeaders(), mutableURL: mediaMainURL)
        return excRequest(requestIn: request)
    }
}
