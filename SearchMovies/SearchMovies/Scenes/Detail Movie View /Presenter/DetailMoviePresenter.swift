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
}

class DetailMoviePresenter: NSObject,  DetailMoviePresenterProtocol {
	func getCellId() -> String {
		return CardViewCell.id
	}
	
	func getCellType() -> AnyClass {
		return CardViewCell.self
	}
}

extension DetailMoviePresenter: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 15
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardViewCell.id, for: indexPath)
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
