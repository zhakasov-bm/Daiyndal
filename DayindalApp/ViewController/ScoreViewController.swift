//
//  ScoreViewController.swift
//  DayindalApp
//
//  Created by Bekzhan on 23.12.2022.
//

import UIKit

class ScoreViewController: UIViewController {
    
    
    let score: UILabel = {
        let label = UILabel()
        label.text = "Score"
        label.font = UIFont.systemFont(ofSize: 48, weight: .medium)
        label.textColor = .mainBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let correctAnswer: UIButton = {
        let button = CustomButton(backgroundColor: .correct, title: "")
        button.setTitleColor(.mainBlue, for: .normal)
        return button
    }()
    
    let wrongAnswer: UIButton = {
        let button = CustomButton(backgroundColor: .wrong, title: "")
        button.setTitleColor(.mainBlue, for: .normal)
        return button
    }()
    
    let stackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        
        self.view.backgroundColor = UIColor(
            patternImage: UIImage(named: "create-background.png")!
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(exit))
    }
    
    func configureView() {
        view.addSubview(score)
        view.addSubview(stackView)
        stackView.addArrangedSubview(correctAnswer)
        stackView.addArrangedSubview(wrongAnswer)
        
        setConstraints()
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            score.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            score.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
        ])
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: score.bottomAnchor, constant: 50),
            stackView.widthAnchor.constraint(equalToConstant: 150),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func exit() {
        dismiss(animated: true)
    }
}

