//
//  MainViewController.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import UIKit

final class MainViewController: ListViewController {
    
    var viewModel: MainViewModel? = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Главная"
        self.setupTableView()
        self.layout()
        self.setupViewModel()
        self.updateControllerResults()
    }
    
    private func setupViewModel() {
        
        
    }
    
    private func setupTableView() {
        self.tableView = UITableView(frame: .zero, style: .insetGrouped)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel?.sections.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else { return 0 }
        return viewModel.sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let viewModel = self.viewModel else { return nil }
        
        let section = viewModel.sections[section]
        
        return section.title
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let viewModel = self.viewModel else { return UITableViewCell() }
        
        let row = viewModel.sections[indexPath.section].rows[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as? TitleCell else {
            return UITableViewCell()
        }
        
        cell.setup(title: row.title)
        cell.accessoryType = .disclosureIndicator
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        guard let viewModel = self.viewModel else { return }
        
        let row = viewModel.sections[indexPath.section].rows[indexPath.row]
        
        self.showViewController(row: row)
        
    }
    
    
}

extension MainViewController {
    
    func showViewController(row: MainSectionRow) {
        
        switch row {
        case is TaskRow:
            let viewController = TaskListViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        case is OperationRow:
            let viewController = OperationListViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        case is VehicleRow:
            let viewController = VehicleListViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        case is ToolRow:
            let viewController = ToolListViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        case is FieldRow:
            let viewController = FieldListViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        case is WorkerRow:
            let viewController = WorkerListViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
        
    }
    
}
