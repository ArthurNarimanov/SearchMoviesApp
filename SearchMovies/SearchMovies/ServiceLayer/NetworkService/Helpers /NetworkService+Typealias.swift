//
//  Helper+Typealias.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/25/21.
//

import Foundation

public typealias HTTPHeaders = [String: String]
public typealias Parameters = [String: Any]
public typealias NetworkRouterComplection = (_ data: Data?,
											 _ responce: URLResponse?,
											 _ error: Error?) ->()
