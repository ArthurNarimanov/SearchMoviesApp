//
//  MainPresenter.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/24/21.
//

import UIKit

protocol MainPresenterProtocol: class, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
	func getCellId() -> String
	func getCellType() -> AnyClass
}

class MainPresenter: NSObject, MainPresenterProtocol {
	func getCellType() -> AnyClass {
		return CardViewWithRatingCell.self
	}
	
	func getCellId() -> String {
		return CardViewWithRatingCell.id
	}
}

extension MainPresenter {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 50
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardViewWithRatingCell.id,
													  for: indexPath)
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
