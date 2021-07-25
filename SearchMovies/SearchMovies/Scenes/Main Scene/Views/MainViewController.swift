//
//  ViewController.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/24/21.
//

import UIKit

class MainViewController: UIViewController {
	
	var presenter: MainPresenterProtocol!

	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.sectionHeadersPinToVisibleBounds = true
		layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.alwaysBounceVertical = true
		collectionView.backgroundColor = .white
		return collectionView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
}

private extension MainViewController {
	func setupUI() {
		view.backgroundColor = .systemYellow
		view.addSubview(collectionView)
		setConstraints()
		setupCollectionView()
	}
	
	func setupCollectionView() {
		collectionView.delegate = presenter
		collectionView.dataSource = presenter
		collectionView.register(presenter.getCellType(),
								forCellWithReuseIdentifier: presenter.getCellId())
	}
	
	func setConstraints() {
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
	}
}
