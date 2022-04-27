//
//  ProgressView.swift
//  Dribbble Project
//
//  Created by J on 2022-04-25.
//

import UIKit

class ProgressView: UIView {
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    private let inset: CGFloat = 20
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonConfiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonConfiguration()
    }
    
    private func commonConfiguration() {
        createCircularPath()
        configureLabel()
        setConstraints()
    }
    
    private func createCircularPath() {
        // created circularPath for circleLayer and progressLayer
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: bounds.size.width / 2 - inset, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        // circleLayer path defined to circularPath
        circleLayer.path = circularPath.cgPath
        // ui edits
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 15.0
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = UIColor(red: 135/255, green: 206/255, blue: 235/255, alpha: 1).cgColor
        circleLayer.opacity = 0.4
        // added circleLayer to layer
        layer.addSublayer(circleLayer)
        
        let circularPath2 = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: bounds.size.width / 2 - inset, startAngle: startPoint, endAngle: Double.pi, clockwise: true)
        // progressLayer path defined to circularPath
        progressLayer.path = circularPath2.cgPath
        // ui edits
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 15.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.white.cgColor
        // added progressLayer to layer
        layer.addSublayer(progressLayer)
    }
    
    private func configureLabel() {
        label.text = "72%"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ])
    }

    func progressAnimation(duration: TimeInterval) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}
