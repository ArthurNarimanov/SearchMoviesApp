//
//  RatingView.swift
//  SearchMovies
//
//  Created by Arthur Narimanov on 7/24/21.
//

import UIKit

final class RatingView: UIView {
	private var number: Int = 0
	private let circleLayer: CAShapeLayer = {
		let shapeLayer = CAShapeLayer()
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.lineCap = .round
		shapeLayer.lineWidth = 2.0
		shapeLayer.strokeColor = UIColor.red.withAlphaComponent(0.72).cgColor
		return shapeLayer
	}()
	
	private var progressLayer: CAShapeLayer = {
		let shapeLayer = CAShapeLayer()
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.lineCap = .round
		shapeLayer.lineWidth = 2.0
		shapeLayer.strokeColor = UIColor.systemGreen.cgColor
		return shapeLayer
	}()
	
	private let circleView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
		return view
	}()
	
	private let ratingCount: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .boldSystemFont(ofSize: 12)
		label.numberOfLines = 1
		label.minimumScaleFactor = 0.5
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .center
		label.textColor = .white
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		assertionFailure("init(coder:) has not been implemented")
		super.init(coder: coder)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		circleView.layer.cornerRadius = bounds.midX
		circleLayer.path = getCircularCGPath(by: 100)
		progressLayer.path = getCircularCGPath(by: number)
	}
	
	public func setGrade(by number: Int) {
		ratingCount.text = "\(number)"
		self.number = number
		setNeedsLayout()
	}
}

private extension RatingView {
	func setupUI() {
		addSubview(circleView)
		addSubview(ratingCount)
		circleView.layer.addSublayer(circleLayer)
		circleView.layer.addSublayer(progressLayer)
		setConstraints()
	}
	
	func setConstraints() {
		NSLayoutConstraint.activate([
			circleView.topAnchor.constraint(equalTo: topAnchor),
			circleView.bottomAnchor.constraint(equalTo: bottomAnchor),
			circleView.leadingAnchor.constraint(equalTo: leadingAnchor),
			circleView.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			ratingCount.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
			ratingCount.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
			ratingCount.leadingAnchor.constraint(equalTo: leadingAnchor),
			ratingCount.trailingAnchor.constraint(equalTo: trailingAnchor),
		])
	}
	
	func getCircularCGPath(by end: Int) -> CGPath {
		let halfPI: CGFloat = .pi / 2
		let endAngle: CGFloat = (.pi / 50) * CGFloat(end) - halfPI
		let circularPath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX,
														   y: bounds.midY),
										radius: bounds.width / 2.0,
										startAngle: -halfPI,
										endAngle: endAngle,
										clockwise: true)
		return circularPath.cgPath
	}
}

