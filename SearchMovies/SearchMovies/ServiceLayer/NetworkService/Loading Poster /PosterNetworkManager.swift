//
//  PosterNetworkManager.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/25/21.
//

import Foundation

protocol PosterNetworkProtocol {
	func getMidleImage(by path: String, completion: @escaping (_ movie: Data?, _ error: NetworkResponceResult?)->())
}

struct PosterNetworkManager: PosterNetworkProtocol {
	let router = NetworkRouter<PosterAPI>()
	
	func getMidleImage(by path: String, completion: @escaping (_ movie: Data?, _ error: NetworkResponceResult?)->()) {
		router.request(.midleImage(path: path)) { (data, response, error) in
			if error != nil {
				completion(nil, NetworkResponceResult.checkNetConnection)
			}
			DispatchQueue.main.async {
			if let response = response as? HTTPURLResponse {
				let result = HandleResponse.getNetworkResponceResult(by: response.statusCode)
				switch result {
					case .success:
						guard let responseData = data else {
							completion(nil, NetworkResponceResult.noData)
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
