//
//  Global.swift
//  Movie
//
//  Created by 김윤수 on 2022/02/03.
//

import Foundation
import UIKit

let baseURL = "https://connect-boxoffice.run.goorm.io/"
let naviTitle: [String] = ["예매율순", "큐레이션", "개봉일순"]
let indicatorView = UIActivityIndicatorView(style: .large)

func calculateStar(_ stack: [UIImageView], _ value: Double) {
    
    var value = value
    for i in 0...4 {
    
        if value >= 2 {
            stack[i].image = UIImage(named: "ic_star_large_full")
            value -= 2
        }
        else if value >= 1 {
            stack[i].image = UIImage(named: "ic_star_large_half")
            value -= 1
        }
        else {
            stack[i].image = UIImage(named: "ic_star_large")
        }
    }
}
