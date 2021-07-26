//
//  Credits.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/26/21.
//

import Foundation

struct Credits: Decodable {
	let cast: [Cast]
}

// MARK: - Cast
struct Cast: Decodable {
	let id: Int
	let name: String
	let profilePath: String?

	enum CodingKeys: String, CodingKey {
		case id
		case name
		case profilePath = "profile_path"
	}
	
	init(from decoder: Decoder) throws {
		let codingKeys = try decoder.container(keyedBy: CodingKeys.self)
		
		id = try codingKeys.decode(Int.self, forKey: .id)
		name = try codingKeys.decode(String.self, forKey: .name)
		profilePath = try? codingKeys.decode(String.self, forKey: .profilePath)
	}
}
