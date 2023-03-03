//
//  FlashCardVC.swift
//  DayindalApp
//
//  Created by Bekzhan
//

import UIKit

class FlashCardViewController: UIViewController {
    
    var array: [QuestionAnswerModel] = []
    
    let button = CustomButton(backgroundColor: .tabBarItemLight, title: "")
    
    var count: Int = 1
    
    let dataLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .tabBarItemLight
        return label
    }()
    
    let forwardBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        button.tintColor = .mainBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addOne), for: .touchUpInside)
        return button
    }()
    
    let backwardBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .mainBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(subtractOne), for: .touchUpInside)
        return button
    }()
    
    let label: UILabel = {
        let text = UILabel()
        text.textColor = .mainBlue
        text.textAlignment = .center
        return text
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 80
        return stack
    }()
    
    var quest = ""
    var ans = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        array = fetchData()
        
        
        configureButton()
        configureStackView()
        configureDataLabel()
        
        label.text = "1/\(array.count)"
        
        self.view.backgroundColor = UIColor(
            patternImage: UIImage(named: "create-background.png")!
        )

        print(array)
        quest = array[0].question
        ans = array[0].answer
        changeCard(.mainOrange, quest)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
    }
    
    func configureDataLabel() {
        view.addSubview(dataLabel)
        
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dataLabel.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            dataLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            dataLabel.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    func configureStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(backwardBtn)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(forwardBtn)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: 300),
            stackView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 50),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func configureButton() {
        view.addSubview(button)
        changeCard(.mainOrange, quest)
        button.setTitleColor(.tabBarItemLight, for: .normal)
        button.layer.cornerRadius = 20
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 300),
            button.heightAnchor.constraint(equalToConstant: 200),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func buttonTapped() {
        if button.tag == 0 {
            changeCard(.mainBlue, ans)
            button.tag = 1
        } else if button.tag == 1 {
            changeCard(.mainOrange, quest)
            button.tag = 0
        }
    }
    
    private func changeCard(_ color: UIColor, _ title: String) {
        button.backgroundColor = color
        dataLabel.text = title
    }
    
    @objc func cancel() {
        dismiss(animated: true)
    }
    
    @objc func addOne() {
        if count != array.count {
            count += 1
            label.text = "\(count)/\(array.count)"
            quest = array[count-1].question
            ans = array[count-1].answer
            changeCard(.mainOrange, quest)
        } else {
            print("can't count is \(count)")
        }
    }
    
    @objc func subtractOne() {
        if count != 1 {
            count -= 1
            label.text = "\(count)/\(array.count)"
            quest = array[count-1].question
            ans = array[count-1].answer
            changeCard(.mainOrange, quest)
        } else {
            print("can't count is \(count)")
        }
    }
}






