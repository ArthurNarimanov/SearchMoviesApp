//
//  DetailMovieViewController.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/24/21.
//

import UIKit

protocol DetailMovieViewProtocol: class {
	func updateData()
	func setPoster(by image: UIImage)
}

class DetailMovieViewController: UIViewController, DetailMovieViewProtocol {
	
	var presenter: DetailMoviePresenterProtocol!
	
	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.showsVerticalScrollIndicator = false
		scrollView.alwaysBounceVertical = true
		scrollView.alwaysBounceHorizontal = false
		scrollView.backgroundColor = .white
		scrollView.bounces = true
		scrollView.contentInset = UIEdgeInsets(top: 20, left: 0,
											   bottom: 20, right: 0)
		return scrollView
	}()
	
	private var contentView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		return view
	}()
	
	private let poster: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = #imageLiteral(resourceName: "notImage")
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = 6
		imageView.layer.masksToBounds = false
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .boldSystemFont(ofSize: 24)
		label.textColor = .black
		label.minimumScaleFactor = 0.5
		label.adjustsFontSizeToFitWidth = true
		label.adjustsFontForContentSizeCategory = true
		label.sizeToFit()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let ratingView: RatingView = {
		let view = RatingView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private let aboutTitle: UILabel = {
		let label = UILabel()
		label.text = "Overview"
		label.numberOfLines = 0
		label.font = .boldSystemFont(ofSize: 18)
		label.textColor = .black
		label.minimumScaleFactor = 0.5
		label.adjustsFontSizeToFitWidth = true
		label.sizeToFit()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.isHidden = true
		return label
	}()
	
	private let aboutSubtitle: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .systemFont(ofSize: 16)
		label.textColor = .black
		label.sizeToFit()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let actorsTitle: UILabel = {
		let label = UILabel()
		label.text = "Actors"
		label.numberOfLines = 0
		label.font = .boldSystemFont(ofSize: 18)
		label.textColor = .black
		label.minimumScaleFactor = 0.5
		label.adjustsFontSizeToFitWidth = true
		label.sizeToFit()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.isHidden = true
		return label
	}()
	
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.sectionHeadersPinToVisibleBounds = false
		layout.scrollDirection = .horizontal
		layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.alwaysBounceVertical = false
		collectionView.alwaysBounceHorizontal = true
		collectionView.backgroundColor = .white
		collectionView.showsHorizontalScrollIndicator = false
		return collectionView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	func updateData() {
		guard let movie = presenter.movie else { return }
		titleLabel.text = movie.title
		aboutSubtitle.text = movie.overview
		let rating: Double = movie.rating ?? 0
		ratingView.setGrade(by: Int(rating * 10))
		actorsTitle.isHidden = movie.credits?.cast.isEmpty ?? true
		aboutTitle.isHidden = movie.overview?.isEmpty ?? true
		collectionView.reloadData()
	}
	
	func setPoster(by image: UIImage) {
		self.poster.image = image
	}
}

private extension DetailMovieViewController {
	func setupUI() {
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		contentView.addSubview(poster)
		contentView.addSubview(titleLabel)
		contentView.addSubview(ratingView)
		contentView.addSubview(aboutTitle)
		contentView.addSubview(aboutSubtitle)
		contentView.addSubview(actorsTitle)
		contentView.addSubview(collectionView)
		
		setConstraints()
		setupCollectionView()
	}
	
	func setConstraints() {
		let width: CGFloat = (UIScreen.main.bounds.width - 50) / 3
		let height: CGFloat = width * 1.5 + 40
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
			
			contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
			
			poster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
			poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			poster.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/5),
			poster.heightAnchor.constraint(equalTo: poster.widthAnchor, multiplier: 1.5),
			
			titleLabel.topAnchor.constraint(equalTo: poster.topAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 6),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			titleLabel.heightAnchor.constraint(equalToConstant: 52),
			
			ratingView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			ratingView.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 8),
			ratingView.widthAnchor.constraint(equalToConstant: 40),
			ratingView.heightAnchor.constraint(equalToConstant: 40),
			
			aboutTitle.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 8),
			aboutTitle.leadingAnchor.constraint(equalTo: poster.leadingAnchor),
			aboutTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			
			aboutSubtitle.topAnchor.constraint(equalTo: aboutTitle.bottomAnchor, constant: 8),
			aboutSubtitle.leadingAnchor.constraint(equalTo: poster.leadingAnchor),
			aboutSubtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			
			actorsTitle.topAnchor.constraint(equalTo: aboutSubtitle.bottomAnchor, constant: 8),
			actorsTitle.leadingAnchor.constraint(equalTo: aboutSubtitle.leadingAnchor),
			actorsTitle.trailingAnchor.constraint(equalTo: aboutSubtitle.trailingAnchor),
			
			collectionView.topAnchor.constraint(equalTo: actorsTitle.bottomAnchor, constant: 8),
			collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
			collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
			collectionView.heightAnchor.constraint(equalToConstant: height),
		])
	}
	
	func setupCollectionView() {
		collectionView.delegate = presenter
		collectionView.dataSource = presenter
		collectionView.register(presenter.getCellType(), forCellWithReuseIdentifier: presenter.getCellId())
	}
}
