//
//  Movie.swift
//  Photoflix
//
//  Created by Liubov Kurets on 28/07/2022.
//

import Foundation

struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_title: String?
    let original_name: String?
    let poster_path: String?
    let title: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
