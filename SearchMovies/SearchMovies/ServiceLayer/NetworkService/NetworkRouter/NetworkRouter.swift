//
//  NetworkRouter.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/25/21.
//

import Foundation

protocol NetworkRouterProtocol: class {
	associatedtype EndPoint: EndPointType
	func request(_ route: EndPoint, completion: @escaping NetworkRouterComplection)
	func cancel()
}

class NetworkRouter<EndPoint: EndPointType>: NetworkRouterProtocol {
	private var task: URLSessionTask?
	
	func request(_ route: EndPoint, completion: @escaping NetworkRouterComplection){
		
		let session = URLSession.shared
		do {
			let request = try self.buildRequest(from: route)
			task = session.dataTask(with: request, completionHandler: { data, response, error in
				completion(data, response, error)
			})
		} catch {
			completion(nil, nil, error)
		}
		self.task?.resume()
	}
	
	func cancel() {
		self.task?.cancel()
	}
}

// MARK: - Private Methods
private extension NetworkRouter {
	func buildRequest(from route: EndPoint) throws -> URLRequest {
		
		var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
								 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
								 timeoutInterval: 10.0)
		
		request.httpMethod = route.httpMethod.rawValue
		do {
			switch route.task {
				case .request:
					request.setValue("application/json", forHTTPHeaderField: "Content-Type")
				case .requestParameters(let bodyParameters,
										let bodyEncoding,
										let urlParameters):
					
					try self.configureParameters(bodyParameters: bodyParameters,
												 bodyEncoding: bodyEncoding,
												 urlParameters: urlParameters,
												 request: &request)
					
				case .requestParametersAndHeaders(let bodyParameters,
												  let bodyEncoding,
												  let urlParameters,
												  let additionalHeaders):
					
					self.addAdditionalHeaders(additionalHeaders, request: &request)
					try self.configureParameters(bodyParameters: bodyParameters,
												 bodyEncoding: bodyEncoding,
												 urlParameters: urlParameters,
												 request: &request)
				case .requestHeaders(additionHeaders: let additionHeaders):
					self.addAdditionalHeaders(additionHeaders, request: &request)
			}
			return request
		} catch {
			throw error
		}
	}
	
	func configureParameters(bodyParameters: Parameters?,
							 bodyEncoding: ParameterEncoding,
							 urlParameters: Parameters?,
							 request: inout URLRequest) throws {
		do {
			try bodyEncoding.encode(urlRequest: &request,
									bodyParameters: bodyParameters, urlParameters: urlParameters)
		} catch {
			throw error
		}
	}
	
	func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
		guard let headers = additionalHeaders else { return }
		
		for (key, value) in headers {
			request.setValue(value, forHTTPHeaderField: key)
		}
	}
}