//
//  Request.swift
//  Movie
//
//  Created by 김윤수 on 2022/01/28.
//

import Foundation
import UIKit

let DidReceiveMovieListNotification = Notification.Name("DidReceiveMovieList")
let DidReceiveMovieDetailNotification = Notification.Name("DidReceiveMovieDetail")
let DidReceiveCommentsNotification = Notification.Name("DidReceiveComments")
let DidRecieveRepleNotification = Notification.Name("DidReceiveReple")
//let naviTitle: [String] = ["예매율순", "큐레이션", "개봉일순"]
//let indicatorView = UIActivityIndicatorView(style: .large)

func requestData<T: Decodable>(_ sub: String, _ para: String, _ type: T.Type, _ noti: Notification.Name) {
    
    
    let session = URLSession(configuration: .default)
    
    // UrlList(Singleton) 객체에 있는 URL 목록에 접근
    
    guard let url = URL(string: "\(baseURL + sub)?\(para)") else { return }
    
    
    // url로부터 네트워킹을 통해 Data객체를 가져오는 작업 생성
    let dataTask = session.dataTask(with: url){ (data: Data?, response: URLResponse?, error:Error?) in
        
        // 네트워킹에 실패했을 때 오류 처리
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else { return }
        
        do {
            
            // 가져온 Data(JSON타입)객체를 디코딩
            let data = try JSONDecoder().decode(type.self, from: data)
            
            // NotificationCenter로 정보를 담은 Notification 발송
            NotificationCenter.default.post(name: noti, object: nil, userInfo: ["data":data])
            
            OperationQueue.main.addOperation {
                indicatorView.stopAnimating()
            }
            
        // 디코딩에 실패했을 때 오류 처리
        } catch(let err) {
            print(err.localizedDescription)
        }
    }
    
    indicatorView.startAnimating()
    
    // 작업 시작
    dataTask.resume()
    
}

func postData<T:Codable, G:Codable>(_ sub: String, _ post:T, _ type:G.Type, _ noti: Notification.Name) {
    
    
    let session = URLSession(configuration: .default)
    
    // UrlList(Singleton) 객체에 있는 URL 목록에 접근
    
    guard let url = URL(string: "\(baseURL + sub)") else { return }
    

    guard let bodyData = try? JSONEncoder().encode(post) else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = bodyData
    
    
    let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else { return }
        
        
        do {
            
            let data = try JSONDecoder().decode(G.self, from: data)
            NotificationCenter.default.post(name: noti, object: nil, userInfo: ["data":data])
            
        } catch (let err) {
            print(err.localizedDescription)
        }
        
    }
    
    task.resume()
    
}

//func calculateStar(_ stack: [UIImageView], _ value: Double) {
//    
//    var value = value
//    for i in 0...4 {
//    
//        if value >= 2 {
//            stack[i].image = UIImage(named: "ic_star_large_full")
//            value -= 2
//        }
//        else if value >= 1 {
//            stack[i].image = UIImage(named: "ic_star_large_half")
//            value -= 1
//        }
//        else {
//            stack[i].image = UIImage(named: "ic_star_large")
//        }
//    }
//}
