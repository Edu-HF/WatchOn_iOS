//
//  SerieContentPresenter.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 22/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation
import UIKit

enum ContentCategorySeries: String {
    case LatestSeries, AirringTodaySeries, PopularitySeries, TopRatedSeries, OnTheAirSeries
}

class SerieContentPresenter: NSObject {
    
    private let serieContentWS: SeriesContentService = SeriesContentService()
    private var mainChapterSelected: Episode!
    var mainErrorResponse: DynamicType<Error>?
    var mainContentSeriesData: DynamicType<[SerieContent]> = DynamicType([])
    var mainSerieContentSelected: DynamicType<SerieContent> = DynamicType(SerieContent())
    
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
        self.getContentForSeries(contentForCategoryIn: .PopularitySeries, resourceIn: .getPopolarSeries)
    }

    
    func getContentForSeries(contentForCategoryIn: ContentCategorySeries, resourceIn: APIResource) {
        
        serieContentWS.getContentForSeries(resourceIn: resourceIn).done { contentSerieIn in
            
            if let sResults = contentSerieIn.results, !sResults.isEmpty {
                self.mainContentSeriesData.value = sResults
            }
            
        }.catch { errorIn in
                self.mainErrorResponse?.value = errorIn
        }
    }
    
    func getSerieContentDetail() {
        
        serieContentWS.getSerieDetail(serieContentIn: mainSerieContentSelected.value).done { serieDetailIn in
            self.mainSerieContentSelected.value = serieDetailIn
        }.catch { errorIn in
            self.mainErrorResponse?.value = errorIn
        }
    }
    
    func getSerieContentDetailEpisodeBySeason(seasonIndexIn: Int) {
        var seasons = self.mainSerieContentSelected.value.serieSeasons
        guard let mSeason = seasons?[seasonIndexIn] else { return }
        serieContentWS.getSerieEpisodesBySeason(serieSeasonIn: mSeason).done { episodesIn in
            if let eResults = episodesIn.results, !eResults.isEmpty {
                seasons?[seasonIndexIn].sEpisodes = eResults
                self.mainSerieContentSelected.value.serieSeasons = seasons
                NotificationCenter.default.post(name: .UpdateEpisodesNoti, object: nil)
            }else{
                seasons?[seasonIndexIn].sEposidesNA = true
                self.mainSerieContentSelected.value.serieSeasons = seasons
                NotificationCenter.default.post(name: .UpdateEpisodesNoti, object: nil)
            }
        }.catch{ errorIn in
            self.mainErrorResponse?.value = errorIn
        }
    }
    
    func getSerieContentCellH() -> CGSize {
        var cellW = UIScreen.main.bounds.width/2
        cellW = cellW - 10
        return CGSize.init(width: cellW, height: 400)
    }
    
    func setEpisodeSelected(episodeIn: Episode) {
        self.mainChapterSelected = episodeIn
        //TODO: The ID's of each episode not content videos, so i used SerieContent ID or Serie ID
        self.mainChapterSelected.eID = self.mainSerieContentSelected.value.serieID
        self.serieContentWS.getContentMedia(episodeIn: self.mainChapterSelected).done { (mediaIn) in
            
            if let tempMediaData = mediaIn.results {
                self.mainChapterSelected.eContentMedia = tempMediaData
                NotificationCenter.default.post(name: .ShowEpisodeNoti, object: nil)
            }
        }.catch { errorIn in
            self.mainErrorResponse?.value = errorIn
        }
    }
    
    func getSerieContentToShowID() -> String {
        
        var mContentID: String = ""
        self.mainChapterSelected.eContentMedia.forEach {
            if $0.mKey != nil && $0.mKey != "" {
                mContentID = $0.mKey!
                return
            }
        }
        
        return mContentID
    }
}
