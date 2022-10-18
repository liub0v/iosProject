//
//  YouTubeSearchResponse.swift
//  Photoflix
//
//  Created by Liubov Kurets on 09/10/2022.
//

import Foundation


struct YouTubeSearchResponse: Codable {
    
    let items: [VideoElement]
    
}
struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
