//
//  Movie.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/25/21.
//

import Foundation

struct Movie: Decodable {
	let id: Int
	var posterPath: String?
	var title: String? = ""
	var rating: Double? = 0
	var overview: String? = ""
	let credits: Credits?
	
	var _title: String {
		return title ?? ""
	}
	
	var _rating: Int {
		let result = (rating ?? 0) * 10
		return Int(result)
	}
	
	enum MovieCodingKeys: String, CodingKey {
		case id
		case posterPath = "poster_path"
		case title
		case rating = "vote_average"
		case overview
		case credits
	}
	
	init(from decoder: Decoder) throws {
		let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
		
		id = try movieContainer.decode(Int.self, forKey: .id)
		posterPath = try? movieContainer.decode(String.self, forKey: .posterPath)
		title = try? movieContainer.decode(String.self, forKey: .title)
		rating = try? movieContainer.decode(Double.self, forKey: .rating)
		overview = try? movieContainer.decode(String.self, forKey: .overview)
		credits = try? movieContainer.decode(Credits.self, forKey: .credits)
	}
}
