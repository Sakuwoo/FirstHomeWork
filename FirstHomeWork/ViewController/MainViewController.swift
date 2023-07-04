//
//  MainViewController.swift
//  FirstHomeWork
//
//  Created by Sevara on 29/6/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private var newsData: [Product] = []
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableViewSetting()
        networking()
        addBarButton()
        title = "someNews"
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barButton))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    @objc func barButton() {
        
        let alertController = UIAlertController(title: "Добавить новый продукт", message: "Заполните все поля!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Добавить", style: .default) { action in
            guard let id = alertController.textFields?.first?.text,
                  let title = alertController.textFields?[1].text else {
                return
            }
            ApiManager.shared.postRequest(
                title: title,
                id: Int(id)!
            ) { result in
                switch result {
                case.success(let statusCode):
                    DispatchQueue.main.async {
                        self.showAlert(title: "status code", message: "Your status code is: \(statusCode)")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        let action2 = UIAlertAction(title: "Назад", style: .cancel)
        
        alertController.addAction(action)
        alertController.addAction(action2)
        alertController.addTextField { tf in
            tf.placeholder = "ID"
        }
        alertController.addTextField { tf in
            tf.placeholder = "Name"
        }
        self.present(alertController, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    private func tableViewSetting() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func networking() {
        ApiManager.shared.getRequest { result in
            switch result {
            case .success(let value):
                self.newsData = value.products ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ProductTableViewCell
        let model = newsData[indexPath.row]
        cell?.updateData(model: model)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

