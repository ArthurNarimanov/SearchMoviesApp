//
//  EndPointType.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/25/21.
//

import Foundation

enum NetworkResult<String> {
	case success
	case failure(String)
}

public enum HTTPMethod: String {
	case post   = "POST"
	case get    = "GET"
	case patch  = "PATCH"
	case put    = "PUT"
	case delete = "DELETE"
}

public enum HTTPTask {
	case request
	case requestParameters(bodyParameters: Parameters?,
						   bodyEncoding: ParameterEncoding,
						   urlParameters: Parameters?)
	case requestParametersAndHeaders(bodyParameters: Parameters?,
									 bodyEncoding: ParameterEncoding,
									 urlParameters: Parameters?,
									 additionHeaders: HTTPHeaders?)
	case requestHeaders(additionHeaders: HTTPHeaders?)
}

public enum NetworkError: String, Error {
	case parametersNil = "Parameters were nil."
	case encodingFailed = "Parameter encoding dailed."
	case missingURL = "URL is nil."
}

///Type Network Environment
public enum NetworkEnvironment {
	case qa
	case production
	case staging
}

public enum NetworkResponseResult: String {
	case success
	case authenticationError = "You need to be authenticated first."
	case badRequest = "Bad request."
	case outdated = "The url requested is outdated."
	case failed = "Network request failed."
	case noData = "Response returned with no data to decode."
	case unableToDecode = "We could not decode the response."
	case checkNetConnection = "Please check your network connection."
}
