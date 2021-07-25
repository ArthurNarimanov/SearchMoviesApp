//
//  CardCollectionViewCell.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/24/21.
//

import UIKit

protocol CardViewModelProtocol {
	var title: String { get set }
	var poster: UIImage { get set }
}

/// UICollectionViewCell
class CardViewCell: UICollectionViewCell {
	
	internal let poster: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleToFill
		imageView.image = #imageLiteral(resourceName: "examplePoster")
		imageView.layer.cornerRadius = 6
		imageView.layer.masksToBounds = false
		imageView.clipsToBounds = true
		return imageView
	}()
	
	internal let title: UILabel = {
		let title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.font = .boldSystemFont(ofSize: 16)
		title.numberOfLines = 0
		title.minimumScaleFactor = 0.1
		title.adjustsFontSizeToFitWidth = true
		title.textAlignment = .left
		return title
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		assertionFailure("init(coder:) has not been implemented")
		super.init(coder: coder)
	}
	
	public func content(by model: CardViewModelProtocol) {
		title.text = model.title
		poster.image = model.poster
	}
}

private extension CardViewCell {
	func setupUI() {
		addSubview(poster)
		addSubview(title)
		
		setConstraints()
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
		])
	}
}
