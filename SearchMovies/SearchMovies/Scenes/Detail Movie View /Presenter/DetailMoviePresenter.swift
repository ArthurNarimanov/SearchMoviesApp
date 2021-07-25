//
//  DetailMoviePresenter.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/25/21.
//

import UIKit

protocol DetailMoviePresenterProtocol: class, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
	func getCellId() -> String
	func getCellType() -> AnyClass
	var movie: Movie? { get }
}

class DetailMoviePresenter: NSObject,  DetailMoviePresenterProtocol {
	private(set) var movie: Movie? {
		didSet {
			setPoster()
		}
	}
	
	private var casts: [Cast]? {
		didSet {
			view.updateData()
		}
	}
	
	private var networkManager: MovieNetworkManagerProtocol
	private var posterNetworkManager: PosterNetworkProtocol
	unowned var view: DetailMovieViewProtocol
	
	init(networkManager: MovieNetworkManagerProtocol,
		 posterNetworkManager: PosterNetworkProtocol,
		 view: DetailMovieViewProtocol,
		 by movieID: Int) {
		self.networkManager = networkManager
		self.view = view
		self.posterNetworkManager = posterNetworkManager
		super.init()
		networkManager.getMovie(by: movieID) { (movie, _) in
			self.movie = movie
			self.casts = movie?.credits?.cast
		}
	}
	
	func getCellId() -> String {
		return CardViewCell.id
	}
	
	func getCellType() -> AnyClass {
		return CardViewCell.self
	}
	
	private func setPoster() {
		posterNetworkManager.getMiddleImage(by: movie?.posterPath ?? "") { [weak self] (data, _) in
			guard let _self = self,
				  let data = data,
				  let image = UIImage(data: data) else { return }
			_self.view.setPoster(by: image)
		}
	}
}

extension DetailMoviePresenter: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return casts?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardViewCell.id, for: indexPath) as! CardViewCell
		let cast: Cast? = casts?[indexPath.item]
		let model: CardViewModelProtocol = CardViewModel(title: cast?.name ?? "")
		cell.content(by: model)
		if let profilePath = cast?.profilePath {
			posterNetworkManager.getMiddleImage(by: profilePath) { (data, _) in
				guard let data = data,
					  let image = UIImage(data: data) else { return }
				cell.setPoster(by: image)
			}
		}
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView,
							layout collectionViewLayout: UICollectionViewLayout,
							sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width: CGFloat = (UIScreen.main.bounds.width - 50) / 3
		let height: CGFloat = width * 1.5 + 40
		return CGSize(width: width, height: height)
	}
}
