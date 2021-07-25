//
//  MainBuilder.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/24/21.
//

import UIKit

protocol Buildable {
	static func getMainVC() -> UIViewController
	static func getDetailMovieVC() -> UIViewController
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
	
	static func getDetailMovieVC() -> UIViewController {
		let vc = DetailMovieViewController()
		vc.presenter = DetailMoviePresenter()
		return vc
	}
}
