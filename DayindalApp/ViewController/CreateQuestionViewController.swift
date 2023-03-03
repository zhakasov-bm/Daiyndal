//
//  CreateQuestionViewController.swift
//  DayindalApp
//
//  Created by Ramazan Amangeldin
//

import UIKit

protocol CreateQuestionProtocol {
    func save(question: String, answer: String)
}

class CreateQuestionViewController: UIViewController {
    
    var delegate: CreateQuestionProtocol?
    
    var questionTextField: UITextField = {
        let textfield = UITextField()
        textfield.textColor = .black
        textfield.font = UIFont.systemFont(ofSize: 16)
        textfield.placeholder = "Enter Question"
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    var answerTextField: UITextField = {
        let textfield = UITextField()
        textfield.textColor = .black
        textfield.font = UIFont.systemFont(ofSize: 16)
        textfield.placeholder = "Enter Answer"
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    var saveButton: UIButton = {
        let button = CustomButton(backgroundColor: .mainOrange, title: "Save")
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "create-background.png")!)

        questionTextField.delegate = self
        answerTextField.delegate = self
        setupView()
    }
}

extension CreateQuestionViewController {
    func setupView() {
        view.addSubview(questionTextField)
        view.addSubview(answerTextField)
        view.addSubview(saveButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            questionTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 57),
            questionTextField.heightAnchor.constraint(equalToConstant: 44),
            questionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            questionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            answerTextField.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: 20),
            answerTextField.heightAnchor.constraint(equalToConstant: 44),
            answerTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            answerTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc func handleSave() {
        if questionTextField.text != "" && answerTextField.text != "" {
            delegate?.save(question: questionTextField.text!, answer: answerTextField.text!)
            dismiss(animated: true, completion: nil)
        }
    }
}

extension CreateQuestionViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == questionTextField {
            answerTextField.becomeFirstResponder()
        } else if textField == answerTextField {
            textField.becomeFirstResponder()
        }
        return true
    }
}
