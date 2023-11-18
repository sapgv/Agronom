//
//  TaskDetailViewController.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import UIKit

final class TaskDetailViewController: ListViewController {
    
    var viewModel: TaskDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Задача"
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
        self.tableView.register(UINib(nibName: "OperationCell", bundle: nil), forCellReuseIdentifier: "OperationCell")
        self.tableView.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
        self.tableView.register(UINib(nibName: "FieldCell", bundle: nil), forCellReuseIdentifier: "FieldCell")
        self.tableView.register(UINib(nibName: "VehicleCell", bundle: nil), forCellReuseIdentifier: "VehicleCell")
        self.tableView.register(UINib(nibName: "WorkerCell", bundle: nil), forCellReuseIdentifier: "WorkerCell")
    }
    
    private func layout() {
        
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
}

extension TaskDetailViewController {
    
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
        
        switch row {
        case is TaskOperationRow:
            
            if let cdOperation = viewModel.cdTaskManager.cdOperation {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "OperationCell", for: indexPath) as? OperationCell else { return UITableViewCell() }
                cell.setup(item: cdOperation)
                cell.accessoryType = .disclosureIndicator
                return cell
            }
            else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as? TitleCell else { return UITableViewCell() }
                cell.setup(title: "Выберите операцию")
                cell.accessoryType = .disclosureIndicator
                return cell
            }
            
        case is TaskFieldRow:
            
            if let cdField = viewModel.cdTaskManager.cdField {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "FieldCell", for: indexPath) as? FieldCell else { return UITableViewCell() }
                cell.setup(item: cdField)
                cell.accessoryType = .disclosureIndicator
                return cell
            }
            else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as? TitleCell else { return UITableViewCell() }
                cell.setup(title: "Выберите поле")
                cell.accessoryType = .disclosureIndicator
                return cell
            }
            
        case is TaskVehicleRow:
            
            if let cdVehicle = viewModel.cdTaskManager.cdVehicle {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleCell", for: indexPath) as? VehicleCell else { return UITableViewCell() }
                cell.setup(item: cdVehicle)
                cell.accessoryType = .disclosureIndicator
                return cell
            }
            else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as? TitleCell else { return UITableViewCell() }
                cell.setup(title: "Выберите транспорт")
                cell.accessoryType = .disclosureIndicator
                return cell
            }
            
        case is TaskWorkerRow:
            
            if let cdWorker = viewModel.cdTaskManager.cdWorker {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorkerCell", for: indexPath) as? WorkerCell else { return UITableViewCell() }
                cell.setup(item: cdWorker)
                cell.accessoryType = .disclosureIndicator
                return cell
            }
            else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as? TitleCell else { return UITableViewCell() }
                cell.setup(title: "Выберите исполнителя")
                cell.accessoryType = .disclosureIndicator
                return cell
            }
            
        default:
            return UITableViewCell()
        }
        
        
    }
}

extension TaskDetailViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        guard let viewModel = self.viewModel else { return }
        
        let row = viewModel.sections[indexPath.section].rows[indexPath.row]
        
        switch row {
        case is TaskOperationRow:
            
            let viewController = OperationListViewController()
            viewController.selectCompletion = { [weak self] cdItem, vc in
                
                guard let self = self else { return }
                
                self.viewModel?.cdTaskManager.cdOperation = self.viewModel?.viewContext.objectInContext(CDTaskOperation.self, objectID: cdItem.objectID)
                
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                
                vc.dismiss(animated: true)
                
            }
            let navigationController = UINavigationController(rootViewController: viewController)
            
            self.present(navigationController, animated: true)
            
        case is TaskFieldRow:
            
            let viewController = FieldListViewController()
            viewController.selectCompletion = { [weak self] cdItem, vc in
                
                guard let self = self else { return }
                
                self.viewModel?.cdTaskManager.cdField = self.viewModel?.viewContext.objectInContext(CDField.self, objectID: cdItem.objectID)
                
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                
                vc.dismiss(animated: true)
                
            }
            let navigationController = UINavigationController(rootViewController: viewController)
            
            self.present(navigationController, animated: true)
            
            
        case is TaskVehicleRow:
            
            let viewController = VehicleListViewController()
            viewController.selectCompletion = { [weak self] cdItem, vc in
                
                guard let self = self else { return }
                
                self.viewModel?.cdTaskManager.cdVehicle = self.viewModel?.viewContext.objectInContext(CDVehicle.self, objectID: cdItem.objectID)
                
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                
                vc.dismiss(animated: true)
                
            }
            let navigationController = UINavigationController(rootViewController: viewController)
            
            self.present(navigationController, animated: true)
            
        case is TaskWorkerRow:
            
            let viewController = WorkerListViewController()
            viewController.selectCompletion = { [weak self] cdItem, vc in
                
                guard let self = self else { return }
                
                self.viewModel?.cdTaskManager.cdWorker = self.viewModel?.viewContext.objectInContext(CDWorker.self, objectID: cdItem.objectID)
                
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                
                vc.dismiss(animated: true)
                
            }
            let navigationController = UINavigationController(rootViewController: viewController)
            
            self.present(navigationController, animated: true)
            
            
        default:
            break
        }
        
        
    }
    
    
}
