//
//  NetworkManager.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/25/21.
// This Network Layer is based on the article
// https://medium.com/flawless-app-stories/writing-network-layer-in-swift-protocol-oriented-approach-4fa40ef1f908
// But modified by me.

import Foundation

protocol MovieNetworkManagerProtocol {
	func getNewMovies(page: Int, completion: @escaping (_ movie: [Movie]?, _ error: NetworkResponseResult?)->())
	func getMovie(by id: Int, completion: @escaping (_ movie: Movie?, _ error: NetworkResponseResult?)->())
}

struct MovieNetworkManager: MovieNetworkManagerProtocol {
	static let environment: NetworkEnvironment = .production
	static let MovieAPIKey = "" // Set key!!!
	let router = NetworkRouter<MovieApi>()
	
	func getNewMovies(page: Int, completion: @escaping (_ movie: [Movie]?, _ error: NetworkResponseResult?)->()) {
		router.request(.newMovies(page: page)) { (data, response, error) in
			if error != nil {
				completion(nil, NetworkResponseResult.checkNetConnection)
			}
			
			if let response = response as? HTTPURLResponse {
				let result = HandleResponse.getNetworkResponceResult(by: response.statusCode)
				switch result {
					case .success:
						guard let responseData = data else {
							completion(nil, NetworkResponseResult.noData)
							return
						}
						do {
							let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
							completion(apiResponse.movies, nil)
						} catch {
							completion(nil, NetworkResponseResult.unableToDecode)
						}
					case .failure(let networkFailureError):
						completion(nil, networkFailureError)
				}
			}
		}
	}
	
	func getMovie(by id: Int, completion: @escaping (Movie?, NetworkResponseResult?) -> ()) {
		router.request(.movie(id: id)) { (data, response, error) in
			if error != nil {
				completion(nil, NetworkResponseResult.checkNetConnection)
			}
			DispatchQueue.main.async {
				if let response = response as? HTTPURLResponse {
					let result = HandleResponse.getNetworkResponceResult(by: response.statusCode)
					switch result {
						case .success:
							guard let responseData = data else {
								completion(nil, NetworkResponseResult.noData)
								return
							}
							do {
								let apiResponse = try JSONDecoder().decode(Movie.self, from: responseData)
								completion(apiResponse, nil)
							}catch {
								completion(nil, NetworkResponseResult.unableToDecode)
							}
						case .failure(let networkFailureError):
							completion(nil, networkFailureError)
					}
				}
			}
		}
	}
}
