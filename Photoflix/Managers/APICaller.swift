//
//  File.swift
//  Photoflix
//
//  Created by Liubov Kurets on 28/07/2022.
//

import Foundation

struct Conatants {
    static let API_KEY = "b44c1f1ce86a707d972e02547616c25c"
    static let baseURL = "https://api.themoviedb.org"
    static let YOUTUBE_API_KEY = "AIzaSyDqb0c7Y0N1SkrK_L2HBaXROKIrhHiE9Kk"
    static let YouTubeBaseURL = "https://youtube.googleapis.com/youtube/v3"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrandingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        
        guard let url = URL(string: "\(Conatants.baseURL)/3/trending/movie/day?api_key=\(Conatants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _,error in
            
            guard let data = data, error == nil else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
            
        
        }
        task.resume()
    }
    
    func getTrandingTvs (completion: @escaping (Result<[Title], Error>)-> Void) {
        guard let url = URL(string: "\(Conatants.baseURL)/3/trending/tv/day?api_key=\(Conatants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies (completion: @escaping (Result<[Title], Error>)-> Void){
        guard let url = URL(string: "\(Conatants.baseURL)/3/movie/upcoming?api_key=\(Conatants.API_KEY)" ) else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
        
    }
    func getPopularMovies (completion: @escaping (Result<[Title], Error>)-> Void){
        guard let url = URL(string: "\(Conatants.baseURL)/3/movie/popular?api_key=\(Conatants.API_KEY)" ) else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
        
    }
    
    func getTopRatedMovies (completion: @escaping (Result<[Title], Error>)-> Void){
        guard let url = URL(string: "\(Conatants.baseURL)/3/movie/top_rated?api_key=\(Conatants.API_KEY)" ) else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIError.failedTogetData))
             }
        }
        task.resume()
        
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>)-> Void) {
      
        
        guard let url = URL(string: "\(Conatants.baseURL)/3/discover/movie?api_key=\(Conatants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate" ) else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIError.failedTogetData))
             }
        }
        task.resume()
        
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>)-> Void) {
        
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return }
        
        guard let url = URL(string: "\(Conatants.baseURL)/3/search/movie?api_key=\(Conatants.API_KEY)&query=\(query )") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIError.failedTogetData))
             }
        }
        task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>)-> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string:"\(Conatants.YouTubeBaseURL)/search?q=\(query)&key=\(Conatants.YOUTUBE_API_KEY )") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(YouTubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
               
                
            } catch{
                print(error.localizedDescription)
                completion(.failure(error))
             }
        }
        task.resume()
    }
                                              
}
