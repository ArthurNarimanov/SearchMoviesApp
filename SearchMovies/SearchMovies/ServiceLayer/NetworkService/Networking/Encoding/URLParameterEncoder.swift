//
//  URLParameterEncoder.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/25/21.
//

import Foundation

public protocol ParameterEncoder {
	static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public struct URLParameterEncoder: ParameterEncoder {
	static public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
		
		guard let url = urlRequest.url else { throw NetworkError.missingURL }
		
		if var urlComponents = URLComponents(url: url,
											 resolvingAgainstBaseURL: false), !parameters.isEmpty {
			
			urlComponents.queryItems = [URLQueryItem]()
			
			for (key,value) in parameters {
				let queryItem = URLQueryItem(name: key,
											 value: "\(value)"
												.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
				urlComponents.queryItems?.append(queryItem)
			}
			urlRequest.url = urlComponents.url
		}
		
		if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
			urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8",
								forHTTPHeaderField: "Content-Type")
		}
		
	}
}

public enum ParameterEncoding {
	
	case urlEncoding
	case jsonEncoding
	case urlAndJsonEncoding
	
	public func encode(urlRequest: inout URLRequest,
					   bodyParameters: Parameters?,
					   urlParameters: Parameters?) throws {
		do {
			switch self {
				case .urlEncoding:
					guard let urlParameters = urlParameters else { return }
					try URLParameterEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
					
				case .jsonEncoding:
					guard let bodyParameters = bodyParameters else { return }
					try JSONParameterEncoder.encode(urlRequest: &urlRequest, with: bodyParameters)
					
				case .urlAndJsonEncoding:
					guard let bodyParameters = bodyParameters,
						  let urlParameters = urlParameters else { return }
					try URLParameterEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
					try JSONParameterEncoder.encode(urlRequest: &urlRequest, with: bodyParameters)
					
			}
		} catch {
			throw error
		}
	}
	
}
