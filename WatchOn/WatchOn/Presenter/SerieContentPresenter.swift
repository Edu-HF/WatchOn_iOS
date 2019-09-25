//
//  SerieContentPresenter.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 22/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation

enum ContentCategorySeries: String {
    case LatestSeries, AirringTodaySeries, PopularitySeries, TopRatedSeries, OnTheAirSeries
}

class SerieContentPresenter: NSObject {
    
    private let serieContentWS: SeriesContentService = SeriesContentService()
    var mainErrorResponse: DynamicType<Error>?
    var mainContentSeriesData: DynamicType<[MainContent]> = DynamicType([])
    
    //MARK: Shared Instance
    class var sharedInstance: SerieContentPresenter {
        struct Static {
            static let instance: SerieContentPresenter = SerieContentPresenter()
        }
        return Static.instance
    }
    
    override init() {}
    
    //MARK: Public Methods
    func getAllContentForSeries() {
        //self.getContentForSeries(contentForCategoryIn: .LatestSeries, resourceIn: .getLatestSeries)
        self.getContentForSeries(contentForCategoryIn: .PopularitySeries, resourceIn: .getPopolarSeries)
    }
    
    func getContentForSeries(contentForCategoryIn: ContentCategorySeries, resourceIn: APIResource) {
        
        serieContentWS.getContentForSeries(resourceIn: resourceIn).done { contentSerieIn in
            
            if let sResults = contentSerieIn.results, !sResults.isEmpty {
                
                var mContent: MainContent!
                switch contentForCategoryIn {
                case .LatestSeries, .AirringTodaySeries, .PopularitySeries, .TopRatedSeries, .OnTheAirSeries:
                    mContent = MainContent.init(contentType: .ContentD, contentTitle: nil, mainContents: nil, mainContentSeries: [])
                }
                
                for serieContent in sResults {
                    mContent.mainContentSeries?.append(serieContent)
                }
                
                self.mainContentSeriesData.value.append(mContent)
            }
        }.catch { errorIn in
                self.mainErrorResponse?.value = errorIn
        }
    }
}
