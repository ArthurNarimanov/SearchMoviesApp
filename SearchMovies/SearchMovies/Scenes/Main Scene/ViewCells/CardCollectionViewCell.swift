//
//  CardCollectionViewCell.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/24/21.
//

import UIKit

final class CardCollectionViewCell: UICollectionViewCell {
	
	private let poster: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleToFill
		imageView.image = #imageLiteral(resourceName: "examplePoster")
		imageView.layer.cornerRadius = 6
		imageView.layer.masksToBounds = false
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private let title: UILabel = {
		let title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = "Майор Гром: Чумной Доктор"
		title.font = .boldSystemFont(ofSize: 16)
		title.numberOfLines = 0
		title.minimumScaleFactor = 0.1
		title.adjustsFontSizeToFitWidth = true
		title.textAlignment = .left
		return title
	}()
	
	private let rating: RatingView = {
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

private extension CardCollectionViewCell {
	func setupUI() {
		addSubview(poster)
		addSubview(title)
		addSubview(rating)
		
		setConstraints()
		rating.setGrade(by: 80)
	}
	
	func setConstraints() {
		NSLayoutConstraint.activate([
			poster.topAnchor.constraint(equalTo: topAnchor),
			poster.leadingAnchor.constraint(equalTo: leadingAnchor),
			poster.trailingAnchor.constraint(equalTo: trailingAnchor),
			poster.heightAnchor.constraint(equalToConstant: bounds.width * 1.5),
			
			title.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 4),
			title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
			title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
			title.heightAnchor.constraint(equalToConstant: 30),
			
			rating.bottomAnchor.constraint(equalTo: title.topAnchor, constant: 4),
			rating.trailingAnchor.constraint(equalTo: poster.trailingAnchor, constant: -4),
			rating.widthAnchor.constraint(equalToConstant: bounds.width * 0.22),
			rating.heightAnchor.constraint(equalToConstant: bounds.width * 0.22),
		])
	}
}
