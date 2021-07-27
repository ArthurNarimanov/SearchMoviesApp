//
//  CardViewModel.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/27/21.
//

import UIKit

protocol CardViewModelProtocol {
	var title: String { get set }
	var poster: UIImage? { get set }
}

struct CardViewModel: CardViewModelProtocol {
	var title: String
	var poster: UIImage? = #imageLiteral(resourceName: "notImage")
}
