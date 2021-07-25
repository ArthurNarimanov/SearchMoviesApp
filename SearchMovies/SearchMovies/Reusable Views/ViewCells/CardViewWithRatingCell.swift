//
//  CardViewWithRatingCell.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/25/21.
//

import UIKit

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
}

private extension CardViewWithRatingCell {
	func setupUI() {
		addSubview(rating)
		
		setRatingConstraints()
		rating.setGrade(by: 80)
	}
	
	func setRatingConstraints() {
		NSLayoutConstraint.activate([
			rating.bottomAnchor.constraint(equalTo: title.topAnchor, constant: 4),
			rating.trailingAnchor.constraint(equalTo: poster.trailingAnchor, constant: -4),
			rating.widthAnchor.constraint(equalToConstant: bounds.width * 0.22),
			rating.heightAnchor.constraint(equalToConstant: bounds.width * 0.22),
		])
	}
}
