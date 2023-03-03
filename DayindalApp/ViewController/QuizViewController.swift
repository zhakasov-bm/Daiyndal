//
//  QuizVC.swift
//  DayindalApp
//
//  Created by Bekzhan
//

import UIKit

class QuizViewController: UIViewController {
    
    var array: [QuestionAnswerModel] = []
    var variants: [String] = []
    
    var timer: Timer!
    
    var count: Int = 1
    
    var quest = ""
    var isAnswer = ""
    
    var n_correct = 0
    var n_wrong = 0
    
    let label: UILabel = {
        let text = UILabel()
        text.textColor = .mainBlue
        text.textAlignment = .center
        return text
    }()
    
    let question: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .mainBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let variant1: UIButton = {
        let button = VariantButton(backgroundColor: .tabBarItemLight, title: "Variant 1")
        button.addTarget(self, action: #selector(isItCorrect), for: .touchUpInside)
        return button
    }()
    
    let variant2: UIButton = {
        let button = VariantButton(backgroundColor: .tabBarItemLight, title: "Variant 2")
        button.addTarget(self, action: #selector(isItCorrect), for: .touchUpInside)
        return button
    }()
    
    let variant3: UIButton = {
        let button = VariantButton(backgroundColor: .tabBarItemLight, title: "Variant 3")
        button.addTarget(self, action: #selector(isItCorrect), for: .touchUpInside)
        return button
    }()
    
    let variant4: UIButton = {
        let button = VariantButton(backgroundColor: .tabBarItemLight, title: "Variant 4")
        button.addTarget(self, action: #selector(isItCorrect), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLabel()
        configureQuestionLabel()
        configureButton()
        
        label.text = "1/\(array.count)"
        
        
        quest = array[0].question
        isAnswer = array[0].answer
        
        changeCard(quest)
        
        for _ in 1...3 {
            variants.append(randomVariant())
        }
        
        variants.append(isAnswer)
        
        variants.shuffle()
        changeVarint(variants)
        
        self.view.backgroundColor = UIColor(
            patternImage: UIImage(named: "create-background.png")!
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(nextQuestion), userInfo: nil, repeats: true)
    }
    
    func configureQuestionLabel() {
        view.addSubview(question)
        
        NSLayoutConstraint.activate([
            question.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            question.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            question.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
        ])
    }
    
    func configureButton() {
        view.addSubview(variant1)
        view.addSubview(variant2)
        view.addSubview(variant3)
        view.addSubview(variant4)
        
        NSLayoutConstraint.activate([
            variant1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            variant1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            variant1.topAnchor.constraint(equalTo: question.bottomAnchor, constant: 30),
            variant1.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            variant2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            variant2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            variant2.topAnchor.constraint(equalTo: variant1.bottomAnchor, constant: 10),
            variant2.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            variant3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            variant3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            variant3.topAnchor.constraint(equalTo: variant2.bottomAnchor, constant: 10),
            variant3.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            variant4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            variant4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            variant4.topAnchor.constraint(equalTo: variant3.bottomAnchor, constant: 10),
            variant4.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureLabel() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 50),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    @objc func cancel() {
        dismiss(animated: true)
    }
    
    private func changeCard(_ question: String) {
        self.question.text = question
    }
    
    private func changeVarint(_ variants: [String]) {
        variant1.setTitle(variants[0], for: .normal)
        variant2.setTitle(variants[1], for: .normal)
        variant3.setTitle(variants[2], for: .normal)
        variant4.setTitle(variants[3], for: .normal)
    }
    
    @objc func isItCorrect(_ button: UIButton) {
        
        if button.titleLabel?.text == isAnswer {
            button.backgroundColor = .correct
            n_correct += 1
        } else {
            button.backgroundColor = .wrong
            n_wrong += 1
            correctAnswer().backgroundColor = .correct
        }
        
        variantMode(false)
        startTimer()
    }
    
    @objc func nextQuestion() {
        if count != array.count {
            count += 1
            label.text = "\(count)/\(array.count)"
            quest = array[count-1].question
            isAnswer = array[count-1].answer
            changeCard(quest)
            setBackground(.tabBarItemLight)
            
            for i in 0...2 {
                variants[i] = randomVariant()
            }
            
            variants[3] = isAnswer
            variants.shuffle()
            changeVarint(variants)
        } else {

            let scoreVC = ScoreViewController()
            scoreVC.correctAnswer.setTitle(String(n_correct), for: .normal)
            scoreVC.wrongAnswer.setTitle(String(n_wrong), for: .normal)
            let nc = UINavigationController(rootViewController: scoreVC)
            
            nc.modalPresentationStyle = .fullScreen
            self.present(nc, animated: true)
        }
        variantMode(true)
        timer.invalidate()
    }
    
    private func correctAnswer() -> UIButton {
        if variant1.titleLabel?.text == isAnswer {
            return variant1
        } else if variant2.titleLabel?.text == isAnswer {
            return variant2
        } else if variant3.titleLabel?.text == isAnswer {
            return variant3
        } else {
            return variant4
        }
    }
    
    private func randomVariant() -> String{
        let variant = array.randomElement()?.answer
        
        if variant != isAnswer { return variant! }
        
        return randomVariant()
    }
    
    private func variantMode(_ mode: Bool) {
        variant1.isEnabled = mode
        variant2.isEnabled = mode
        variant3.isEnabled = mode
        variant4.isEnabled = mode
    }
    
    private func setBackground(_ color: UIColor) {
        variant1.backgroundColor = color
        variant2.backgroundColor = color
        variant3.backgroundColor = color
        variant4.backgroundColor = color
    }
}
