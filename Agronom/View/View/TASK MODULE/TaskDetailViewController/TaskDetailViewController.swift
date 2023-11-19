//
//  TaskDetailViewController.swift
//  Agronom
//
//  Created by Grigory Sapogov on 19.11.2023.
//

import UIKit

final class TaskDetailViewController: ListViewController {
    
    var viewModel: TaskDetailViewModel?
    
    private let bottomView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let finishedTaskLabel = {
        let label = UILabel()
        label.text = "Задача завершена"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .systemGreen
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private let bottomStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    private let startCheckListButton: StartCheckListButton = StartCheckListButton()
    
    private let finishCheckListButton: FinishCheckListButton = FinishCheckListButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Задача"
        self.setupTableView()
        self.layout()
        self.setupViewModel()
        self.setupNavigationButton()
        self.setupAction()
        self.updateBottomView()
    }
    
    private func setupAction() {
        
        self.startCheckListButton.action = { [weak self] in
            
            guard let self = self else { return }
            guard let task = self.viewModel?.cdTaskManager else { return }
            
            let viewContext = Model.coreData.createChildContextFromCoordinator(for: .mainQueueConcurrencyType, mergePolicy: .mergeByPropertyObjectTrump)
            let cdItem = viewContext.objectInContext(CDTaskManager.self, objectID: task.objectID)!
            
            let viewModel = StartCheckListEditViewModel(viewContext: viewContext, cdItem: cdItem)
            let viewController = StartCheckListEditViewController()
            viewController.viewModel = viewModel
            viewController.checkListCompletion = { [weak self] vc in
                
                vc.dismiss(animated: true)
                self?.viewModel?.viewContext.refreshAllObjects()
                self?.updateBottomView()
                
            }
            
            let navigationController = UINavigationController(rootViewController: viewController)
            self.present(navigationController, animated: true)
            
        }
        
        self.finishCheckListButton.action = { [weak self] in
            
            guard let self = self else { return }
            guard let task = self.viewModel?.cdTaskManager else { return }
            
            let viewContext = Model.coreData.createChildContextFromCoordinator(for: .mainQueueConcurrencyType, mergePolicy: .mergeByPropertyObjectTrump)
            let cdItem = viewContext.objectInContext(CDTaskManager.self, objectID: task.objectID)!
            
            let viewModel = FinishCheckListEditViewModel(viewContext: viewContext, cdItem: cdItem)
            let viewController = FinishCheckListEditViewController()
            viewController.viewModel = viewModel
            viewController.checkListCompletion = { [weak self] vc in
                
                vc.dismiss(animated: true)
                self?.viewModel?.viewContext.refreshAllObjects()
                self?.updateBottomView()
                
            }
            
            let navigationController = UINavigationController(rootViewController: viewController)
            self.present(navigationController, animated: true)
            
        }
        
    }
    
    private func setupViewModel() {
        
        
    }
    
    private func setupNavigationButton() {
        
//        let button = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))
//        self.navigationItem.rightBarButtonItem = button
        
    }
    
    @objc
    private func save() {
        
//        self.viewModel?.save()
        
    }
    
    
    
    private func updateBottomView() {
        
        self.startCheckListButton.isHidden = self.viewModel?.cdTaskManager.datetime_started != nil
        self.finishCheckListButton.isHidden = self.viewModel?.cdTaskManager.datetime_completed != nil || self.viewModel?.cdTaskManager.datetime_started == nil
     
        self.finishedTaskLabel.isHidden = self.viewModel?.cdTaskManager.datetime_completed == nil
    }
    
    override func layout() {
        
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.bottomView)
        self.view.addSubview(self.bottomStackView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        self.startCheckListButton.translatesAutoresizingMaskIntoConstraints = false
        self.finishCheckListButton.translatesAutoresizingMaskIntoConstraints = false
        self.finishedTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.bottomView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.bottomView.topAnchor.constraint(equalTo: self.tableView.bottomAnchor).isActive = true
        self.bottomView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.bottomView.addSubview(bottomStackView)
        
        self.bottomStackView.addArrangedSubview(self.startCheckListButton)
        self.bottomStackView.addArrangedSubview(self.finishCheckListButton)
        self.bottomStackView.addArrangedSubview(self.finishedTaskLabel)
        
        self.bottomStackView.leadingAnchor.constraint(equalTo: self.bottomView.leadingAnchor, constant: 8).isActive = true
        self.bottomStackView.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 8).isActive = true
        self.bottomStackView.trailingAnchor.constraint(equalTo: self.bottomView.trailingAnchor, constant: -8).isActive = true
        self.bottomStackView.bottomAnchor.constraint(equalTo: self.bottomView.bottomAnchor, constant: -8).isActive = true
        
        self.startCheckListButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.finishCheckListButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.bottomConstraint = self.bottomView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        self.bottomConstraint?.isActive = true
        
    }
    
    private func setupTableView() {
        self.tableView = UITableView(frame: .zero, style: .insetGrouped)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "OperationCell", bundle: nil), forCellReuseIdentifier: "OperationCell")
        self.tableView.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
        self.tableView.register(UINib(nibName: "FieldCell", bundle: nil), forCellReuseIdentifier: "FieldCell")
        self.tableView.register(UINib(nibName: "VehicleCell", bundle: nil), forCellReuseIdentifier: "VehicleCell")
        self.tableView.register(UINib(nibName: "ToolCell", bundle: nil), forCellReuseIdentifier: "ToolCell")
        self.tableView.register(UINib(nibName: "WorkerCell", bundle: nil), forCellReuseIdentifier: "WorkerCell")
        self.tableView.register(UINib(nibName: "TaskParameterCell", bundle: nil), forCellReuseIdentifier: "TaskParameterCell")
        self.tableView.register(UINib(nibName: "EditTextCell", bundle: nil), forCellReuseIdentifier: "EditTextCell")
        self.tableView.register(UINib(nibName: "SubtitleCell", bundle: nil), forCellReuseIdentifier: "SubtitleCell")
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
            
        case is TaskToolRow:
            
            if let cdTool = viewModel.cdTaskManager.cdTool {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToolCell", for: indexPath) as? ToolCell else { return UITableViewCell() }
                cell.setup(item: cdTool)
                cell.accessoryType = .disclosureIndicator
                return cell
            }
            else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as? TitleCell else { return UITableViewCell() }
                cell.setup(title: "Выберите оборудование")
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
            
        case is TaskDepthRow:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubtitleCell", for: indexPath) as? SubtitleCell else {
                return UITableViewCell()
            }
            
            cell.titleLabel.text = "Глубина см"
            cell.textValueLabel.text = "\(self.viewModel?.cdTaskManager.depth ?? 0)"
            
            return cell
            
        case is TaskSpeedRow:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubtitleCell", for: indexPath) as? SubtitleCell else {
                return UITableViewCell()
            }
            
            cell.titleLabel.text = "Рабочая скорость км/ч"
            cell.textValueLabel.text = "\(self.viewModel?.cdTaskManager.speed ?? 0)"
            
            return cell

        case is TaskLiquidRow:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubtitleCell", for: indexPath) as? SubtitleCell else {
                return UITableViewCell()
            }
            
            cell.titleLabel.text = "Расход рабочего раствора л/га"
            cell.textValueLabel.text = "\(self.viewModel?.cdTaskManager.liquid ?? 0)"
            
            return cell
            
        case is TaskDescriptionRow:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubtitleCell", for: indexPath) as? SubtitleCell else {
                return UITableViewCell()
            }
            
            cell.titleLabel.text = "Описание"
            cell.textValueLabel.textAlignment = .left
            cell.textValueLabel.text = self.viewModel?.cdTaskManager.descriptionText
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
    }
}

extension TaskDetailViewController {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        defer {
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
//
//        guard let viewModel = self.viewModel else { return }
//
//        let row = viewModel.sections[indexPath.section].rows[indexPath.row]
//
//        switch row {
//        case is TaskOperationRow:
//
//            let viewController = OperationListViewController()
//            viewController.selectCompletion = { [weak self] cdItem, vc in
//
//                guard let self = self else { return }
//
//                self.viewModel?.cdTaskManager.cdOperation = self.viewModel?.viewContext.objectInContext(CDTaskOperation.self, objectID: cdItem.objectID)
//
//                self.tableView.reloadRows(at: [indexPath], with: .automatic)
//
//                vc.dismiss(animated: true)
//
//            }
//            let navigationController = UINavigationController(rootViewController: viewController)
//
//            self.present(navigationController, animated: true)
//
//        case is TaskFieldRow:
//
//            let viewController = FieldListViewController()
//            viewController.selectCompletion = { [weak self] cdItem, vc in
//
//                guard let self = self else { return }
//
//                self.viewModel?.cdTaskManager.cdField = self.viewModel?.viewContext.objectInContext(CDField.self, objectID: cdItem.objectID)
//
//                self.tableView.reloadRows(at: [indexPath], with: .automatic)
//
//                vc.dismiss(animated: true)
//
//            }
//            let navigationController = UINavigationController(rootViewController: viewController)
//
//            self.present(navigationController, animated: true)
//
//
//        case is TaskVehicleRow:
//
//            let viewController = VehicleListViewController()
//            viewController.selectCompletion = { [weak self] cdItem, vc in
//
//                guard let self = self else { return }
//
//                self.viewModel?.cdTaskManager.cdVehicle = self.viewModel?.viewContext.objectInContext(CDVehicle.self, objectID: cdItem.objectID)
//
//                self.tableView.reloadRows(at: [indexPath], with: .automatic)
//
//                vc.dismiss(animated: true)
//
//            }
//            let navigationController = UINavigationController(rootViewController: viewController)
//
//            self.present(navigationController, animated: true)
//
//        case is TaskToolRow:
//
//            let viewController = ToolListViewController()
//            viewController.selectCompletion = { [weak self] cdItem, vc in
//
//                guard let self = self else { return }
//
//                self.viewModel?.cdTaskManager.cdTool = self.viewModel?.viewContext.objectInContext(CDTool.self, objectID: cdItem.objectID)
//
//                self.tableView.reloadRows(at: [indexPath], with: .automatic)
//
//                vc.dismiss(animated: true)
//
//            }
//            let navigationController = UINavigationController(rootViewController: viewController)
//
//            self.present(navigationController, animated: true)
//
//        case is TaskWorkerRow:
//
//            let viewController = WorkerListViewController()
//            viewController.selectCompletion = { [weak self] cdItem, vc in
//
//                guard let self = self else { return }
//
//                self.viewModel?.cdTaskManager.cdWorker = self.viewModel?.viewContext.objectInContext(CDWorker.self, objectID: cdItem.objectID)
//
//                self.tableView.reloadRows(at: [indexPath], with: .automatic)
//
//                vc.dismiss(animated: true)
//
//            }
//            let navigationController = UINavigationController(rootViewController: viewController)
//
//            self.present(navigationController, animated: true)
//
//
//        default:
//            break
//        }
//
//
//    }
    
    
}
