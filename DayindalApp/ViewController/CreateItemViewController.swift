//
//  CreateItemViewController.swift
//  DayindalApp
//
//  Created by Ramazan Amangeldin
//

import UIKit

protocol CreateItemProtocol {
    func save(title: String, icon: UIImage)
}

class CreateItemViewController: UIViewController {
    
    var delegate: CreateItemProtocol?
    var selectedIcon: UIImage?
    
    var subjects: [UIImage?] = [
        UIImage(named: "carbon"),
        UIImage(named: "clarity"),
        UIImage(named: "game-icons"),
        UIImage(named: "outline_english"),
        UIImage(named: "sharp-biotech"),
        UIImage(named: "document"),
        UIImage(named: "math"),
        UIImage(named: "language"),
        UIImage(named: "rule"),
        UIImage(named: "computer")
    ]
    
    var textField: UITextField = {
        let textfield = UITextField()
        textfield.textColor = .black
        textfield.font = UIFont.systemFont(ofSize: 16)
        textfield.placeholder = "Title"
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 16, height: 104)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(CreateItemCollectionViewCell.self, forCellWithReuseIdentifier: "CreateItemCollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.red.withAlphaComponent(0.0)
        return collectionView
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
        
        textField.delegate = self
        setupView()
    }
}

extension CreateItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreateItemCollectionViewCell", for: indexPath) as? CreateItemCollectionViewCell
        cell?.configureCell(icon: subjects[indexPath.row] ?? UIImage(), isSelected: selectedIcon == subjects[indexPath.row])
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIcon = subjects[indexPath.row]
        updateCollectionView()
    }
}

extension CreateItemViewController {
    func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(textField)
        view.addSubview(collectionView)
        view.addSubview(saveButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: saveButton.topAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func updateCollectionView() {
        self.collectionView.reloadData()
    }
    
    @objc func handleSave() {
        if textField.text != "" && selectedIcon != nil {
            delegate?.save(title: textField.text!, icon: selectedIcon!)
//            (self.tabBarController?.viewControllers?[1] as? ExamVC)?.tableView.reloadData()
            dismiss(animated: true, completion: nil)
        }
    }
}

extension CreateItemViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
