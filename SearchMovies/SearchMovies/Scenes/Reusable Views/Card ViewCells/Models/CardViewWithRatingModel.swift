//
//  CardViewWithRatingModel.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/27/21.
//

import UIKit

protocol CardViewWithRatingModelProtocol: CardViewModelProtocol {
	var rating: Int { get set }
}

struct CardViewWithRatingModel: CardViewWithRatingModelProtocol {
	var rating: Int
	var poster: UIImage?
	var title: String
	
	internal init(rating: Int, title: String, poster: UIImage) {
		self.rating = rating
		self.title = title
		self.poster = poster
	}
}
