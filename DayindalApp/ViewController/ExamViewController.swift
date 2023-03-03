//
//  ExamVC.swift
//  DayindalApp
//
//  Created by Bekzhan on 23.12.2022.
//

import UIKit

class ExamViewController: UIViewController {
    
    var beka: [SubjectModel] = []
    
    var tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("VIEW APPEARED")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("VIEW DID LOAD")
        configureTableView()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "create-background.png")!)
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.backgroundColor = UIColor.red.withAlphaComponent(0.0)
        tableView.pin(to: view)
    }

    
    func setTableViewDelegates() {
        tableView.delegate = self
    }
}


extension ExamViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let testVC = TestViewController()
        testVC.bekas = beka
        let nc = UINavigationController(rootViewController: testVC)
        nc.modalPresentationStyle = .fullScreen
        self.present(nc, animated: true)
        print("selected")
        
//        print(beka)
    }
}



