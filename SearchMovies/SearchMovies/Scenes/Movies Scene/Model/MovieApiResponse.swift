//
//  MovieApiResponse.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/26/21.
//

import Foundation

struct MovieApiResponse: Decodable {
	let page: Int
	let totalResults: Int?
	let totalPages: Int?
	let movies: [Movie]?
	
	var _totalPages: Int {
		return totalResults ?? 0
	}
	
	private enum MovieApiResponseCodingKeys: String, CodingKey {
		case page
		case numberOfResults = "total_results"
		case totalPages = "total_pages"
		case movies = "results"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
		
		page = try container.decode(Int.self, forKey: .page)
		totalResults = try? container.decode(Int.self, forKey: .numberOfResults)
		totalPages = try? container.decode(Int.self, forKey: .totalPages)
		movies = try? container.decode([Movie].self, forKey: .movies)
	}
}
