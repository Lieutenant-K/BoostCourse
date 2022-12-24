//
//  UrlList.swift
//  Movie
//
//  Created by 김윤수 on 2022/01/28.
//

import Foundation

class UrlList {
    static let urlList = UrlList()
    
    var baseURL = "https://connect-boxoffice.run.goorm.io/"
    var subURL = "movies"
    var sortOrder = "order_type=0"
    var movieId = "id="
    
    
    private init(){
        
    }

}
