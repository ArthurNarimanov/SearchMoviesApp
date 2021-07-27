//
//  HandleResponse.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/25/21.
//

import Foundation

struct HandleResponse {
	///Check Responce Status by status code
	static func getNetworkResponseResult(by statusCode: Int) -> NetworkResult<NetworkResponseResult> {
		switch statusCode {
			case 200 ... 299: return .success
			case 400 ... 500: return .failure(NetworkResponseResult.authenticationError)
			case 501 ... 599: return .failure(NetworkResponseResult.badRequest)
			case 600: return .failure(NetworkResponseResult.outdated)
			default: return .failure(NetworkResponseResult.failed)
		}
	}
}
