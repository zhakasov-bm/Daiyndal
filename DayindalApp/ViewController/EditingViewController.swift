//
//  AdditionVC.swift
//  DayindalApp
//
//  Created by Bekzhan on 22.12.2022.
//

import UIKit

protocol DeleteQuestionProtocol {
    func delete(_ index: Int)
}

protocol ChangeQuestionProtocol {
    func change(_ question: String, _ answer: String, _ index: Int)
}

class EditingViewController: UIViewController {
    
    var delegate: DeleteQuestionProtocol?
    var delegateChange: ChangeQuestionProtocol?
    
    let newQuestionTF = UITextField()
    let newAnswerTF = UITextField()
    
    let deleteButton = CustomButton(backgroundColor: .wrong, title: "Delete")
    let changeButton = CustomButton(backgroundColor: .systemBlue, title: "Change")
    
    var changed_question: String = ""
    var changed_answer: String = ""
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Editing"
        
        newQuestionTF.delegate = self
        newAnswerTF.delegate = self
        
        configureSaveButton()
        configureQuestionTF()
        configureAnswerTF()
        configureDeleteButton()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "create-background.png")!)
        
        newQuestionTF.text = changed_question
        newAnswerTF.text = changed_answer
    }
    
    
    @objc func deleteData() {
        delegate?.delete(index!)
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func changeButtonTapped() {
        
        if newQuestionTF.text != "" && newAnswerTF.text != "" {
            changed_question = newQuestionTF.text ?? ""
            changed_answer = newAnswerTF.text ?? ""
            
            delegateChange?.change(changed_question, changed_answer, index!)
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    func configureQuestionTF() {
        view.addSubview(newQuestionTF)
        newQuestionTF.placeholder = "Enter question"
        newQuestionTF.borderStyle = .roundedRect
        newQuestionTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newQuestionTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            newQuestionTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            newQuestionTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            newQuestionTF.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureAnswerTF() {
        view.addSubview(newAnswerTF)
        newAnswerTF.placeholder = "Enter answer"
        newAnswerTF.borderStyle = .roundedRect
        newAnswerTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newAnswerTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            newAnswerTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            newAnswerTF.topAnchor.constraint(equalTo: newQuestionTF.bottomAnchor, constant: 10),
            newAnswerTF.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureSaveButton() {
        view.addSubview(changeButton)
        changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            changeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            changeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            changeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            changeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureDeleteButton() {
        view.addSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(deleteData), for: .touchUpInside)
        deleteButton.setTitleColor(.systemRed, for: .normal)
        deleteButton.layer.borderWidth = 0.5
        deleteButton.layer.borderColor = UIColor.systemRed.cgColor
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            (deleteButton).leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            (deleteButton).trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            (deleteButton).bottomAnchor.constraint(equalTo: changeButton.topAnchor, constant: -10),
            (deleteButton).heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension EditingViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == newQuestionTF {
            newAnswerTF.becomeFirstResponder()
        } else if textField == newAnswerTF {
            textField.becomeFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
