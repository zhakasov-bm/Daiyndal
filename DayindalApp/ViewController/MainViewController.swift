//
//  MainViewController.swift
//  DayindalApp
//
//  Created by Ramazan Amangeldin
//

import UIKit

class MainViewController: UIViewController {
    
    struct Cells {
        static let myCell = "myCell"
    }
    
    var examVC: ExamViewController?
    
    var subjects: [SubjectModel] = []
    
    var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 16, height: 155)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView.backgroundColor = UIColor.red.withAlphaComponent(0.0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        setupView()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjects.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell
            cell?.configureCell(icon: UIImage(named: "plus") ?? UIImage(), title: "Add Card", textColor: .lightGray)
            return cell!
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell
            cell?.configureCell(icon: subjects[indexPath.row - 1].icon, title: subjects[indexPath.row - 1].title, textColor: .mainBlue)
            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = CreateItemViewController()
            vc.delegate = self
            vc.modalPresentationStyle = .formSheet
            self.present(vc, animated: true)
        } else {
            let vc = DetailViewController()
            vc.delegate = self
            vc.subject = subjects[indexPath.row - 1]
            let nc = UINavigationController(rootViewController: vc)
            nc.modalPresentationStyle = .fullScreen
            self.present(nc, animated: true)
        }
    }
}

extension MainViewController {
    func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        setupConstraints()

        examVC = self.tabBarController?.viewControllers?[1] as? ExamViewController
        examVC?.tableView.dataSource = self
        examVC?.tableView.register(ExamTableViewCell.self, forCellReuseIdentifier: Cells.myCell)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainViewController: CreateItemProtocol {
    func save(title: String, icon: UIImage) {
        subjects.append(SubjectModel(icon: icon, title: title, index: subjects.count))
        examVC?.tableView.reloadData()
        examVC?.beka = subjects
        self.collectionView.reloadData()   
    }
}

extension MainViewController: SubjectProtocol {
    func save(index: Int, questions: [QuestionAnswerModel]) {
        subjects[index].questions = questions
        examVC?.beka = subjects
    }
}

//For secondTabBarController
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.myCell, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = subjects[indexPath.row].title
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    //delete with swipe
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            subjects.remove(at: indexPath.row)
//            examVC?.tableView.reloadData()
//        }
//    }
}
