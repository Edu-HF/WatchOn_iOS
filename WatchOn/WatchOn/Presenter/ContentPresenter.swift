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

class ContentPresenter: NSObject {
    
    //MARK: - Properties
    var mainContentData: DynamicType<[MainContent]> = DynamicType([])
    private let contentWS: ContentService = ContentService()
    
    //MARK: - Public Methods
    func getPopularityMovies() {
        
        contentWS.getPopularityMovies().done { contentsIn in
            
            if var tempContents = contentsIn.results {
                self.mainContentData.value.append(MainContent(contentType: .Section, contentTitle: "Populares", mainContents: []))
                for conten in tempContents {
                    self.mainContentData.value.append(MainContent(contentType: ContentKind.randomKind(), contentTitle: "", mainContents: []))
                }
            }
            
            }.catch{ error in
                print("Error")
        }
    }
}
