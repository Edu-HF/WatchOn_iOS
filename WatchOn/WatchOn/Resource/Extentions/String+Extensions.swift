//
//  String+Extensions.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 29/08/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation

extension String {
    
    func buildURLStringIMG() -> String {
        let mainDict = Bundle.main.infoDictionary
        let bURL = mainDict?["API_IMG_BASE_URL"] as! String
        return bURL + self
    }
    
    func buildGenderNamesString(contentGenrersIn: [Int]) -> String {
        
        let genders = ContentPresenter.sharedIntance.mainGenresData.value
        var index: Int = 0
        var genres: String = ""
        for cGenreID in genders {
            for genreID in contentGenrersIn {
                if index == 4 {
                    break
                }
                if genreID == cGenreID.genreID {
                    index += 1
                    genres = genres + cGenreID.genreName
                    genres += " • "
                }
            }
        }
        
        if genres.count > 3 {
            genres.remove(at: genres.index(genres.endIndex, offsetBy: -2))
        }
        return genres
    }
}
