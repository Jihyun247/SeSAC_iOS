//
//  Movie.swift
//  TrendMedia
//
//  Created by 김지현 on 2021/10/22.
//

import Foundation

typealias Genre = String
typealias ImageUrl = String

struct Movie {
    let engTitle: String
    let korTitle: String
    let releaseDate: String
    let genre: Genre
    let region: String
    let overview: String
    let rate: Double
    let starring: String
    let backdropImage: ImageUrl
}
