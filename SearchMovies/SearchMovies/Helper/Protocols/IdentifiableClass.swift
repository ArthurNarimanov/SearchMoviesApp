//
//  IdentifiableClass.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/24/21.
//

import UIKit

/// Sets the identifier by the class name
protocol IdentifiableClass: AnyObject {
	static var id: String { get }
}

extension IdentifiableClass {
	static var id: String {
		return String(describing: self)
	}
}

extension UICollectionViewCell: IdentifiableClass {}
