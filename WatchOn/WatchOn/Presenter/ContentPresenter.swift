//
//  ContentPresenter.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 21/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation

enum ContentKind: String, CaseIterable {
    case Section, ContentA, ContentB, ContentC
    
    static func randomKind() -> ContentKind {
        let randomNumber = Int(arc4random_uniform(UInt32(2)))
        return ContentKind.allCases[randomNumber]
    }
}

enum ContentCategoryMovies: String {
    case discoverMovies, trendingMovies, popularityMovies, topRatedMovies, upcomingMovies
}

class ContentPresenter: NSObject {
    
    //MARK: - Properties
    var mainContentData: DynamicType<[MainContent]> = DynamicType([])
    var mainGenresData: DynamicType<[Genre]> = DynamicType([])
    private let contentWS: ContentService = ContentService()
    
    
    //MARK: - Public Methods
    func getAllContentForMovies() {
        getContentForMovies(contentForCategoryIn: .discoverMovies, resourceIn: .getDiscoverMovies)
        getContentForMovies(contentForCategoryIn: .trendingMovies, resourceIn: .getTrendingMovies)
        getContentForMovies(contentForCategoryIn: .popularityMovies, resourceIn: .getPopularityMovies)
        getContentForMovies(contentForCategoryIn: .topRatedMovies, resourceIn: .getTopRatedMovies)
        getContentForMovies(contentForCategoryIn: .upcomingMovies, resourceIn: .getUpcomingMovies)
    }
    
    func getContentForMovies(contentForCategoryIn: ContentCategoryMovies, resourceIn: APIResource) {
        
        contentWS.getContentForMovies(resourceIn: resourceIn).done { contentIn in
            
            if let cResults = contentIn.results, !cResults.isEmpty {
                
                var mContent: MainContent!
                switch contentForCategoryIn {
                    
                case .discoverMovies:
                    self.mainContentData.value.append(MainContent(contentType: .Section, contentTitle: contentForCategoryIn.rawValue, mainContents: nil))
                    mContent = MainContent(contentType: .ContentA, contentTitle: nil, mainContents: [])
                case .trendingMovies:
                    self.mainContentData.value.append(MainContent(contentType: .Section, contentTitle: contentForCategoryIn.rawValue, mainContents: nil))
                    mContent = MainContent(contentType: .ContentB, contentTitle: nil, mainContents: [])
                case .popularityMovies:
                    self.mainContentData.value.append(MainContent(contentType: .Section, contentTitle: contentForCategoryIn.rawValue, mainContents: nil))
                    mContent = MainContent(contentType: .ContentA, contentTitle: nil, mainContents: [])
                case .topRatedMovies:
                    self.mainContentData.value.append(MainContent(contentType: .Section, contentTitle: contentForCategoryIn.rawValue, mainContents: nil))
                    mContent = MainContent(contentType: .ContentA, contentTitle: nil, mainContents: [])
                case .upcomingMovies:
                    self.mainContentData.value.append(MainContent(contentType: .Section, contentTitle: contentForCategoryIn.rawValue, mainContents: nil))
                    mContent = MainContent(contentType: .ContentB, contentTitle: nil, mainContents: [])
                
                }
                
                for content in cResults {
                    mContent.mainContents?.append(content)
                }
                
                self.mainContentData.value.append(mContent)
            }
            
            }.catch { error in
                print(error)
        }
    }
    
    func getGenresMovies() {
        
        contentWS.getGenres().done { genresIn in
            
            if let tempGenresData = genresIn.genres {
                self.mainGenresData.value = tempGenresData
                self.getAllContentForMovies()
            }
            
            }.catch{ error in
                print("error")
        }
    }
}
