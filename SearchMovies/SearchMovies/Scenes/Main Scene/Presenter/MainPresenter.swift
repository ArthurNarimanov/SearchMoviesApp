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
	
	private var isLoadingPage: Bool = false
	private var page: Int = 1
	private var pageTotal: Int = 1
	
	private var movies = [Movie]() {
		didSet {
			view.updateContent()
		}
	}
	
// MARK: - MainPresenterProtocol
	func getCellType() -> AnyClass {
		return CardViewWithRatingCell.self
	}
	
	func getCellId() -> String {
		return CardViewWithRatingCell.id
	}
	
	func viewIsReady() {
		loadMovies(by: page)
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
		let model: CardViewWithRatingModelProtocol = CardViewWithRatingModel(rating: movie._rating,
																			 title: movie.title ?? "",
																			 poster: #imageLiteral(resourceName: "notImage"))
		
		posterNetworkManager.getMiddleImage(by: movie.posterPath ?? "") { (data, _) in
			if let data = data, let poster =  UIImage(data: data) {
				cell.setPoster(by: poster)
			}
		}

		cell.content(by: model)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView,
							layout collectionViewLayout: UICollectionViewLayout,
							sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width: CGFloat = (UIScreen.main.bounds.width - 50) / 3
		let height: CGFloat = width * 1.5 + 40
		return CGSize(width: width, height: height)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let id = movies[indexPath.item].id
		let detailViewController = MainBulder.getDetailMovieVC(by: id)
		view.pushView(detailViewController)
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let height = scrollView.contentSize.height - scrollView.bounds.size.height
		
		if scrollView.contentOffset.y >= height,
		   page < pageTotal, !isLoadingPage {
			page += 1
			loadMovies(by: page)
		}
	}
}

//MARK: - Private Methods
private extension MainPresenter {
	/// Load New Movies by page
	func loadMovies(by page: Int) {
		isLoadingPage = true
		networkManager.getNewMovies(page: page) { [weak self] (moviesApi, result) in
			DispatchQueue.main.async {
			
			guard let _self = self,
				  let moviesApi = moviesApi,
				  let moves = moviesApi.movies else {
				self?.isLoadingPage = false
				self?.page -= 1
				return
			}
				_self.movies.append(contentsOf: moves)
				_self.pageTotal = moviesApi._totalPages
				_self.page = moviesApi.page
				_self.isLoadingPage = false
			}
		}
	}
}
