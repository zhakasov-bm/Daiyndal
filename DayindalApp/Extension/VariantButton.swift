//
//  VariantButton.swift
//  DayindalApp
//
//  Created by Bekzhan on 22.12.2022.
//

import UIKit

class VariantButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        configure()
    }
    
    func configure() {
        layer.cornerRadius = 10
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowColor = UIColor.mainBlue.cgColor
        layer.borderWidth = 0.2
        layer.shadowOpacity = 0.2
        titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.mainBlue, for: .normal)
        
        addTarget(self, action: #selector(changeColor), for: .touchUpInside)
    }

    @objc func changeColor() {
        
    }
}
