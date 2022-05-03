//
//  Model.swift
//  Movie
//
//  Created by 김윤수 on 2022/01/26.
//

import Foundation

struct MovieList: Codable {
    let order: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case order = "order_type"
        case movies
    }
}

struct Movie: Codable {
    
    let grade: Int
    let thumb: String
    let reserveGrade: Int
    let title: String
    let reserveRate: Double
    let userRating: Double
    let date: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case grade, thumb, title, date, id
        case reserveGrade = "reservation_grade"
        case reserveRate = "reservation_rate"
        case userRating = "user_rating"
    }
    
}
 

struct MovieDetail: Codable {
    
    let audience: Int
    let actor: String
    let duration: Int
    let director: String
    let synopsis: String
    let genre: String
    let grade: Int
    let image: String
    let reserveGrade: Int
    let title: String
    let reserveRate: Double
    let userRating: Double
    let date: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case audience, actor, duration, director, synopsis, genre,
        grade, image, title, date, id
        case reserveRate = "reservation_rate"
        case reserveGrade = "reservation_grade"
        case userRating = "user_rating"
        
    }
    
}

struct Comments: Codable {
    
    let comments: [Comment]
    
}
    
struct Comment: Codable {
    
    let id: String
    let rating: Double
    let timestamp: Double
    let writer: String
    let contents: String
    let movieId: String
    
    enum CodingKeys: String, CodingKey {
        
        case id, rating, timestamp, writer, contents
        case movieId = "movie_id"
        
    }
    
}

struct Reple: Codable {
    let rating: Double
    let writer: String
    let movieId: String
    let contents: String
    
    enum CodingKeys: String, CodingKey {
        case rating, writer, contents
        case movieId = "movie_id"
    }
}


struct PostedComment: Codable {
    let rating: Double
    let timestamp: Double
    let writer: String
    let movieId: String
    let contents: String
    
    enum CodingKeys: String, CodingKey {
        case rating, writer, contents, timestamp
        case movieId = "movie_id"
    }
}
    

    
