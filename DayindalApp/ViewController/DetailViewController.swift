//
//  DetailViewController.swift
//  DayindalApp
//
//  Created by Ramazan Amangeldin
//

import UIKit

protocol SubjectProtocol {
    func save(index: Int, questions: [QuestionAnswerModel])
}

class DetailViewController: UIViewController {
    
    var delegate: SubjectProtocol?
    
    var subject: SubjectModel? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barStyle = .default
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .white
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(QuestionTableViewCell.self, forCellReuseIdentifier: "QuestionTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subject?.questions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell", for: indexPath) as? QuestionTableViewCell
        cell?.configureCell(question: subject?.questions[indexPath.row].question, answer: subject?.questions[indexPath.row].answer)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = EditingViewController()
        detailVC.index = indexPath.row
        detailVC.changed_question = subject?.questions[indexPath.row].question ?? ""
        detailVC.changed_answer = subject?.questions[indexPath.row].answer ?? ""
        detailVC.delegate = self
        detailVC.delegateChange = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //delete with swipe
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            subject?.questions.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
}

extension DetailViewController {
    func setupView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "delete"), style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.title = subject?.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(handlePlus))
        
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
        ])
    }
    
    @objc func handleCancel() {
        delegate?.save(index: subject?.index ?? 0, questions: subject?.questions ?? [])
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handlePlus() {
        let vc = CreateQuestionViewController()
        vc.delegate = self
        self.present(vc, animated: true)
    }
}

extension DetailViewController: CreateQuestionProtocol, DeleteQuestionProtocol, ChangeQuestionProtocol {
    
    func save(question: String, answer: String) {
        subject?.questions.append(QuestionAnswerModel(question: question, answer: answer))
        self.tableView.reloadData()
    }
    
    func delete(_ index: Int) {
        subject?.questions.remove(at: index)
        self.tableView.reloadData()
    }
    
    func change(_ question: String, _ answer: String, _ index: Int) {
        subject?.questions[index] = QuestionAnswerModel(question: question, answer: answer)
        self.tableView.reloadData()
    }
}
