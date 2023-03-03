//
//  TestViewController.swift
//  DayindalApp
//
//  Created by Bekzhan on
//


import UIKit

class TestViewController: UIViewController {

    var bekas: [SubjectModel] = []
    
    let flashCardButton = CustomButton(backgroundColor: .mainBlue, title: "FlashCards")
    let testButton = CustomButton(backgroundColor: .mainBlue, title: "Test")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureFlashCardButton()
        configureTestButton()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "create-background.png")!)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
    }
    
    func configureFlashCardButton() {
        view.addSubview(flashCardButton)
        flashCardButton.setTitleColor(.tabBarItemLight, for: .normal)
        flashCardButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        flashCardButton.layer.cornerRadius = 10
        flashCardButton.layer.shadowColor = UIColor.mainBlue.cgColor
        flashCardButton.layer.shadowOpacity = 0.5
        flashCardButton.addTarget(self, action: #selector(flashCardButtonTapped), for: .touchUpInside)
        setFlashCardButtonConstraints()
    }
    
    func configureTestButton() {
        view.addSubview(testButton)
        testButton.setTitleColor(.tabBarItemLight, for: .normal)
        testButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        testButton.layer.cornerRadius = 10
        testButton.layer.shadowColor = UIColor.mainBlue.cgColor
        testButton.layer.shadowOpacity = 0.5
        testButton.addTarget(self, action: #selector(testButtonTapped), for: .touchUpInside)
        setTestButtonConstraints()
    }
    
    @objc func flashCardButtonTapped() {
        print("FlashCarButton tapped")
        let flashCardVC = FlashCardViewController()
        print(bekas[0].questions)
        for beka in bekas {
            flashCardVC.array = beka.questions
        }
        
        let nc = UINavigationController(rootViewController: flashCardVC)
        nc.modalPresentationStyle = .fullScreen
        self.present(nc, animated: true)

    }
    
    @objc func testButtonTapped() {
        print("TestButton tapped")
        let testVC = QuizViewController()
        
        for beka in bekas {
            testVC.array = beka.questions
        }
        
        let nc = UINavigationController(rootViewController: testVC)
        nc.modalPresentationStyle = .fullScreen
        self.present(nc, animated: true)
    }
    
    
    func setFlashCardButtonConstraints() {
        flashCardButton.translatesAutoresizingMaskIntoConstraints = false
        flashCardButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        flashCardButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        flashCardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        flashCardButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
    }
    
    func setTestButtonConstraints() {
        testButton.translatesAutoresizingMaskIntoConstraints = false
        testButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        testButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        testButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        testButton.topAnchor.constraint(equalTo: flashCardButton.bottomAnchor, constant: 20).isActive = true
    }
    
    
    @objc func cancel() {
        dismiss(animated: true)
    }
}

