//
//  PosterNetworkManager.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/25/21.
//

import Foundation

protocol PosterNetworkProtocol {
	func getMiddleImage(by path: String, completion: @escaping (_ movie: Data?,
																_ error: NetworkResponseResult?)->())
}
/// Download posters from the Network
struct PosterNetworkManager: PosterNetworkProtocol {
	let router = NetworkRouter<PosterAPI>()
	
	func getMiddleImage(by path: String, completion: @escaping (_ movie: Data?,
																_ error: NetworkResponseResult?)->()) {
		
		router.request(.middleImage(path: path)) { (data, response, error) in
			DispatchQueue.main.async {
			if error != nil {
				completion(nil, NetworkResponseResult.checkNetConnection)
			}
				if let response = response as? HTTPURLResponse {
					let result = HandleResponse.getNetworkResponseResult(by: response.statusCode)
					switch result {
						case .success:
							guard let responseData = data else {
								completion(nil, NetworkResponseResult.noData)
								return
							}
							completion(responseData, nil)
							
						case .failure(let networkFailureError):
							completion(nil, networkFailureError)
					}
				}
			}
		}
	}
	
}
