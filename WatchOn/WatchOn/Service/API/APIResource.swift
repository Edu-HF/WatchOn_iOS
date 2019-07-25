//
//  APIResource.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 21/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation
import Alamofire

protocol EndPointType {
    var baseURL: URL { get }
    var urlPath: String { get }
}

enum APIResource {
    case getPopularityMovies, getTopRatedMovies, getUpcomingMovies, getPopularitySeries, getTopRatedSeries, getUpcomingSeries
}

struct APIError: Codable {
    let success: Bool
    let error: APIErrorDesc
}

struct APIErrorDesc: Codable {
    let message, name: String
    let code: Int
}

extension APIResource: EndPointType {
    var baseURL: URL {
        let mainDict = Bundle.main.infoDictionary
        let bURL = mainDict?["SERVER_URL"] as! String
        return URL(string: bURL)!
    }
    
    var urlPath: String {
        switch self {
            case .getPopularityMovies: return "/movie/popular"
            case .getTopRatedMovies: return "/movie/top_rated"
            case .getUpcomingMovies: return "/movie/upcoming"
            case .getPopularitySeries: return "/tv/popular"
            case .getTopRatedSeries: return "/tv/top_rated"
            case .getUpcomingSeries: return "/tv/latest"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPopularityMovies, .getTopRatedMovies, .getUpcomingMovies, .getPopularitySeries, .getTopRatedSeries, .getUpcomingSeries: return .get
        }
    }
}
