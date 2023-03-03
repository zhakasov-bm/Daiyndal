//
//  CreateItemCollectionViewCell.swift
//  DayindalApp
//
//  Created by Ramazan Amangeldin 
//

import UIKit

class CreateItemCollectionViewCell: UICollectionViewCell {
    
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CreateItemCollectionViewCell {
    func setupView() {
        layer.cornerRadius = 16
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        backgroundColor = .white
        
        addSubview(iconImageView)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureCell(icon: UIImage, isSelected: Bool) {
        if isSelected {
            backgroundColor = .mainOrange
        } else {
            backgroundColor = .white
        }
        
        iconImageView.image = icon
    }
}
