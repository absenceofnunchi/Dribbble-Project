//
//  TaskCollectionViewCell.swift
//  Dribbble Project
//
//  Created by J on 2022-04-26.
//

import UIKit

class TaskCollectionViewCell: UICollectionViewCell {
    static let identifier = "TaskCollectionViewCell"
    
    let upperContainer = UIView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let moreSymbol = UIButton()
    let lowerContainer = UIView()
    let progressLabel = UILabel()
    let percentageLabel = UILabel()
    let sliderView = SliderView()
    let dateLabel = UILabel()
    let inset: CGFloat = 15
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        
        upperContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(upperContainer)
        
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        upperContainer.addSubview(titleLabel)
        
        subtitleLabel.textColor = .lightGray
        subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        subtitleLabel.alpha = 0.7
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        upperContainer.addSubview(subtitleLabel)
        
        moreSymbol.translatesAutoresizingMaskIntoConstraints = false
        upperContainer.addSubview(moreSymbol)
        
        lowerContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lowerContainer)
        
        progressLabel.textColor = .lightGray
        progressLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        progressLabel.alpha = 0.7
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        lowerContainer.addSubview(progressLabel)
        
        percentageLabel.textColor = .blue
        percentageLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        percentageLabel.alpha = 0.7
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        lowerContainer.addSubview(percentageLabel)
        
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        lowerContainer.addSubview(sliderView)
        
        dateLabel.textColor = .lightGray
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        dateLabel.alpha = 0.7
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        lowerContainer.addSubview(dateLabel)
        
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        layer.cornerRadius = 10
        clipsToBounds = false
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            upperContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            upperContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            upperContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            upperContainer.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.45),
            
            titleLabel.topAnchor.constraint(equalTo: upperContainer.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: upperContainer.leadingAnchor),
            titleLabel.heightAnchor.constraint(equalTo: upperContainer.heightAnchor, multiplier: 0.5),
            titleLabel.widthAnchor.constraint(equalTo: upperContainer.widthAnchor, multiplier: 0.8),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: upperContainer.leadingAnchor),
//            subtitleLabel.heightAnchor.constraint(equalTo: upperContainer.heightAnchor, multiplier: 0.5),
            subtitleLabel.widthAnchor.constraint(equalTo: upperContainer.widthAnchor, multiplier: 0.8),
            
            moreSymbol.topAnchor.constraint(equalTo: upperContainer.topAnchor),
            moreSymbol.trailingAnchor.constraint(equalTo: upperContainer.trailingAnchor),
            moreSymbol.widthAnchor.constraint(equalTo: upperContainer.widthAnchor, multiplier: 0.2),
            moreSymbol.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            
            lowerContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            lowerContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lowerContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lowerContainer.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.55),
            
            progressLabel.topAnchor.constraint(equalTo: lowerContainer.topAnchor),
            progressLabel.leadingAnchor.constraint(equalTo: lowerContainer.leadingAnchor),
            progressLabel.heightAnchor.constraint(equalTo: lowerContainer.heightAnchor, multiplier: 0.3),
            progressLabel.widthAnchor.constraint(equalTo: lowerContainer.widthAnchor, multiplier: 0.8),
            
            percentageLabel.topAnchor.constraint(equalTo: lowerContainer.topAnchor),
            percentageLabel.trailingAnchor.constraint(equalTo: lowerContainer.trailingAnchor),
            percentageLabel.heightAnchor.constraint(equalTo: lowerContainer.heightAnchor, multiplier: 0.3),
            percentageLabel.widthAnchor.constraint(equalTo: lowerContainer.widthAnchor, multiplier: 0.2),
            
            sliderView.topAnchor.constraint(equalTo: progressLabel.bottomAnchor),
            sliderView.leadingAnchor.constraint(equalTo: lowerContainer.leadingAnchor),
            sliderView.heightAnchor.constraint(equalTo: lowerContainer.heightAnchor, multiplier: 0.3),
            sliderView.widthAnchor.constraint(equalTo: lowerContainer.widthAnchor, multiplier: 1),
            
            dateLabel.topAnchor.constraint(equalTo: sliderView.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: lowerContainer.leadingAnchor),
            dateLabel.heightAnchor.constraint(equalTo: lowerContainer.heightAnchor, multiplier: 0.3),
            dateLabel.widthAnchor.constraint(equalTo: lowerContainer.widthAnchor, multiplier: 1),
        ])
    }
}


class SliderView: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: bounds.size.height / 2))
        path.addLine(to: CGPoint(x: bounds.size.width - 10, y: bounds.size.height / 2))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 2
        shapeLayer.lineCap = .round
        shapeLayer.strokeColor = UIColor.blue.cgColor
        self.layer.addSublayer(shapeLayer)
    }
}
