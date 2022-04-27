//
//  CategoryCollectionViewCell.swift
//  Dribbble Project
//
//  Created by J on 2022-04-27.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    var stackView: UIStackView!
    let imageView = UIImageView()
    let button = UIButton()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let sliderView = SliderView()
    let dateLabel = UILabel()
    let upperContainer = UIView()
    let middleContainer = UIView()
    let lowerContainer = UIView()
    let inset: CGFloat = 20

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        upperContainer.addSubview(imageView)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        upperContainer.addSubview(button)
        
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        middleContainer.addSubview(titleLabel)
        
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        subtitleLabel.textColor = .lightGray
        subtitleLabel.alpha = 0.7
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        middleContainer.addSubview(subtitleLabel)
        
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        lowerContainer.addSubview(sliderView)
        
        dateLabel.textColor = .lightGray
        dateLabel.alpha = 0.7
        dateLabel.textAlignment = .right
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        lowerContainer.addSubview(dateLabel)
        
        stackView = UIStackView(arrangedSubviews: [upperContainer, middleContainer, lowerContainer])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
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
            imageView.leadingAnchor.constraint(equalTo: upperContainer.leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: upperContainer.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: upperContainer.heightAnchor, multiplier: 0.8),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            button.trailingAnchor.constraint(equalTo: upperContainer.trailingAnchor),
            button.topAnchor.constraint(equalTo: upperContainer.topAnchor),
            button.bottomAnchor.constraint(equalTo: upperContainer.bottomAnchor),
            button.widthAnchor.constraint(equalTo: button.heightAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: middleContainer.centerYAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: middleContainer.leadingAnchor),
            subtitleLabel.centerYAnchor.constraint(equalTo: middleContainer.centerYAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: middleContainer.leadingAnchor),
            
            sliderView.leadingAnchor.constraint(equalTo: lowerContainer.leadingAnchor),
            sliderView.topAnchor.constraint(equalTo: lowerContainer.topAnchor),
            sliderView.bottomAnchor.constraint(equalTo: lowerContainer.bottomAnchor),
            sliderView.widthAnchor.constraint(equalTo: lowerContainer.widthAnchor, multiplier: 0.8),
            
            dateLabel.topAnchor.constraint(equalTo: lowerContainer.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: lowerContainer.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: lowerContainer.bottomAnchor),
            dateLabel.widthAnchor.constraint(equalTo: lowerContainer.widthAnchor, multiplier: 0.2),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
        ])
    }
}
