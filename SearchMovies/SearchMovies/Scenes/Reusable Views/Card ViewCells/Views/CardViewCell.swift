//
//  CardCollectionViewCell.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/24/21.
//

import UIKit

/// UICollectionViewCell
public class CardViewCell: UICollectionViewCell {
	//MARK: - Internal Properties
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
	
	//MARK: - Life cycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		assertionFailure("init(coder:) has not been implemented")
		super.init(coder: coder)
	}
	
	//MARK: - Public Methods
	func content(by model: CardViewModelProtocol) {
		title.text = model.title
		poster.image = model.poster
	}
	
	func setPoster(by image: UIImage) {
		poster.image = image
	}
}

//MARK: - Private Methods
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
