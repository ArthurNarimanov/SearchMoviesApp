//
//  MovieEndPoint.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/25/21.
//

import Foundation

public enum MovieApi: EndPointType {
	case recommended(id: Int)
	case popular(page: Int)
	case newMovies(page: Int)
	case video(id: Int)
	case movie(id: Int)
	
	var environmentBaseURL : String {
		switch MovieNetworkSettings.environment {
			case .production: return "https://api.themoviedb.org/3/movie/"
			case .qa: return "https://qa.themoviedb.org/3/movie/"
			case .staging: return "https://staging.themoviedb.org/3/movie/"
		}
	}
	
	var baseURL: URL {
		guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
		return url
	}
	
	var path: String {
		switch self {
			case .recommended(let id):
				return "\(id)/recommendations"
			case .popular:
				return "popular"
			case .newMovies:
				return "now_playing"
			case .video(let id):
				return "\(id)/videos"
			case .movie(let id):
				return "\(id)"
		}
	}
	
	var httpMethod: HTTPMethod {
		return .get
	}
	
	var task: HTTPTask {
		switch self {
			case .newMovies(let page):
				return .requestParameters(bodyParameters: nil,
										  bodyEncoding: .urlEncoding,
										  urlParameters: [
											"page": page,
											"api_key": MovieNetworkSettings.APIKey
										  ])
			case .movie(_):
				return .requestParameters(bodyParameters: nil,
										  bodyEncoding: .urlEncoding,
										  urlParameters: [
											"api_key": MovieNetworkSettings.APIKey,
											"append_to_response": "credits"
										  ])
			default:
				return .request
		}
	}
	
	var headers: HTTPHeaders? {
		return nil
	}
}
