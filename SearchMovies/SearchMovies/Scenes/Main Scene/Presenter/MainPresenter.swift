//
//  MainPresenter.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/24/21.
//

import UIKit

protocol BasePresenter: class {
	func viewIsReady()
}

protocol MainPresenterProtocol: BasePresenter, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
	func getCellId() -> String
	func getCellType() -> AnyClass
}

class MainPresenter: NSObject, MainPresenterProtocol {
	
	unowned var view: MainViewProtocol!
	var networkManager: MovieNetworkManagerProtocol!
	var posterNetworkManager: PosterNetworkProtocol!
	
	private var movies = [Movie]() {
		didSet {
			view.updateContent()
		}
	}
	
	func getCellType() -> AnyClass {
		return CardViewWithRatingCell.self
	}
	
	func getCellId() -> String {
		return CardViewWithRatingCell.id
	}
	
	func viewIsReady() {
		networkManager.getNewMovies(page: 1) { [weak self] (movies, result) in
			guard let _self = self,
				  let movies = movies else { return }
			DispatchQueue.main.async {
				_self.movies.append(contentsOf: movies)
			}
		}
	}
}

extension MainPresenter {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return movies.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardViewWithRatingCell.id,
													  for: indexPath) as! CardViewWithRatingCell
		let movie = movies[indexPath.item]
		let model: CardViewWithRatingModelProtocol = CardViewWithRatingModel(rating: Int(movie.rating * 10),
																			 title: movie.title,
																			 poster: #imageLiteral(resourceName: "notImage"))
		cell.content(by: model)
		
		posterNetworkManager.getMidleImage(by: movie.posterPath) { (data, result) in
			if let data = data, let poster =  UIImage(data: data) {
				cell.setPoster(by: poster)
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
