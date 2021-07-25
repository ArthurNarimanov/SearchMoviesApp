//
//  MainBuilder.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/24/21.
//

import UIKit

protocol Buildable {
	static func getMainVC() -> UIViewController
	static func getDetailMovieVC(by id: Int) -> UIViewController
}

struct MainBulder: Buildable {
	static func getMainVC() -> UIViewController {
		let vc = MainViewController()
		let presenter = MainPresenter()
		presenter.networkManager = MovieNetworkManager()
		presenter.view = vc
		presenter.posterNetworkManager = PosterNetworkManager()
		vc.presenter = presenter
		return vc
	}
	
	static func getDetailMovieVC(by id: Int) -> UIViewController {
		let vc = DetailMovieViewController()
		let networkManager = MovieNetworkManager()
		let posterNetworkManager = PosterNetworkManager()
		let presenter = DetailMoviePresenter(networkManager: networkManager,
											 posterNetworkManager: posterNetworkManager,
											 view: vc,
											 by: id)
		vc.presenter = presenter
		return vc
	}
}
