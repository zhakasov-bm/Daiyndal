//
//  MainCollectionViewCell.swift
//  DayindalApp
//
//  Created by Ramazan Amangeldin 
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var subjectLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainCollectionViewCell {
    func setupView() {
        layer.cornerRadius = 16
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        backgroundColor = .white
        
        addSubview(iconImageView)
        addSubview(subjectLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 38),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            subjectLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 5),
            subjectLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subjectLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -44)
        ])
    }
    
    func configureCell(icon: UIImage, title: String, textColor: UIColor) {
        iconImageView.image = icon
        subjectLabel.text = title
        subjectLabel.textColor = textColor
    }
}
