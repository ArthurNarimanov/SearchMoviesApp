//
//  CardCollectionViewCell.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/24/21.
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

/// UICollectionViewCell
class CardViewCell: UICollectionViewCell {
	
	internal let poster: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.image = #imageLiteral(resourceName: "notImage")
		imageView.layer.cornerRadius = 6
		imageView.layer.masksToBounds = false
		imageView.clipsToBounds = true
		return imageView
	}()
	
	internal let title: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .boldSystemFont(ofSize: 16)
		label.textColor = .black
		label.numberOfLines = 0
		label.minimumScaleFactor = 0.1
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .left
		return label
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
	
	public func setPoster(by image: UIImage) {
		poster.image = image
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
