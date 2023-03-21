//
//  ViewController.swift
//  weather app
//
//  Created by Алексей Волобуев on 13.03.2023.
//

import UIKit

protocol ViewInputDelegate: AnyObject {
    func setupData(viewModel: [FirstViewModel])
}

class FirstViewController: UIViewController {
    let cellId = "cellId"
    var viewOutputDelegate: ViewOutputDelegate?
    var tableView = UITableView(frame: .zero, style: .plain)
    var viewModel = [FirstViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewOutputDelegate?.getData()
        createTable()
        view.addSubview(tableView)
        addConstraints()
    }
    
    func createTable() {
        tableView.register(CustomCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func addConstraints () {
        let safeArea = self.view.safeAreaLayoutGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
    }

}

extension FirstViewController: ViewInputDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func setupData(viewModel: [FirstViewModel]) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomCell
        cell.configureCell()
        cell.cityLabel.text = viewModel[indexPath.row].name
        cell.conditionLabel.text = viewModel[indexPath.row].condition
        cell.tempLabel.text = "\(viewModel[indexPath.row].temp)°C"
        cell.icon.image = viewModel[indexPath.row].icon
        return cell
    }

}

