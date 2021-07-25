//
//  HandleResponse.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/25/21.
//

import Foundation

struct HandleResponse {
	///Check Responce Status by status code
	static func getNetworkResponceResult(by statusCode: Int) -> NetworkResult<NetworkResponceResult> {
		switch statusCode {
			case 200 ... 299: return .success
			case 400 ... 500: return .failure(NetworkResponceResult.authenticationError)
			case 501 ... 599: return .failure(NetworkResponceResult.badRequest)
			case 600: return .failure(NetworkResponceResult.outdated)
			default: return .failure(NetworkResponceResult.failed)
		}
	}
}
