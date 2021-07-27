//
//  ViewController.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/24/21.
//

import UIKit

protocol MainViewProtocol: class {
	func updateContent()
	func pushView(_ view: UIViewController)
}

class MoviesViewController: UIViewController, MainViewProtocol {
	//	MARK: - Public Properties
	var presenter: MainPresenterProtocol!
	
	//	MARK: - Private Properties
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
		presenter.viewIsReady()
		setupUI()
	}
	
	//	MARK: - Public Methods
	func updateContent() {
		collectionView.reloadData()
	}
	
	func pushView(_ view: UIViewController) {
		guard let nc = navigationController else { return }
		nc.pushViewController(view, animated: true)
	}
}

//	MARK: - Private Methods
private extension MoviesViewController {
	func setupUI() {
		title = "New Movies"
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
