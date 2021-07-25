//
//  CardViewWithRatingCell.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/25/21.
//

import UIKit

protocol CardViewWithRatingModelProtocol: CardViewModelProtocol {
	var rating: Int { get set }
}

typealias VoidImageClosure = (UIImage?) -> Void

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

/// UICollectionViewCell
/// CardViewCell
class CardViewWithRatingCell: CardViewCell {
	
	fileprivate let rating: RatingView = {
		let rating = RatingView()
		rating.translatesAutoresizingMaskIntoConstraints = false
		return rating
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		assertionFailure("init(coder:) has not been implemented")
		super.init(coder: coder)
	}
	
	public func content(by model: CardViewWithRatingModelProtocol) {
		title.text = model.title
		rating.setGrade(by: model.rating)
		poster.image = model.poster
	}
	
	public func setPoster(by image: UIImage?) {
		self.poster.image = image
	}
}

private extension CardViewWithRatingCell {
	func setupUI() {
		addSubview(rating)
		setRatingConstraints()
	}
	
	func setRatingConstraints() {
		NSLayoutConstraint.activate([
			rating.bottomAnchor.constraint(equalTo: title.topAnchor, constant: -4),
			rating.trailingAnchor.constraint(equalTo: poster.trailingAnchor, constant: -4),
			rating.widthAnchor.constraint(equalToConstant: bounds.width * 0.22),
			rating.heightAnchor.constraint(equalToConstant: bounds.width * 0.22),
		])
	}
}
