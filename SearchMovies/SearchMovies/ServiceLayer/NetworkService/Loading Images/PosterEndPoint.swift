//
//  PosterEndPoint.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/25/21.
//

import Foundation

public enum PosterAPI: EndPointType {
	case middleImage(path: String)
	case largeImage(path: String)
	
	var environmentBaseURL : String {
		return "https://image.tmdb.org/t/p/"
	}
	
	var baseURL: URL {
		guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
		return url
	}
	
	var path: String {
		switch self {
			case .middleImage(path: let path):
				return "w200/\(path)"
			case .largeImage(path: let path):
				return "w500/\(path)"
		}
	}
	
	var httpMethod: HTTPMethod {
		return .get
	}
	
	var task: HTTPTask {
		switch self {
			default:
				return .request
		}
	}
	
	var headers: HTTPHeaders? {
		return nil
	}
}
