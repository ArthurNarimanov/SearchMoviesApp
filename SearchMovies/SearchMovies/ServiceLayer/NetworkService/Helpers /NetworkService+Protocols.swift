//
//  Helper+Protocols.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/25/21.
//

import Foundation

protocol EndPointType {
	var baseURL: URL { get }
	var path: String { get }
	var httpMethod: HTTPMethod { get }
	var task: HTTPTask { get }
	var headers: HTTPHeaders? { get }
}

