//
//  StartCheckListEditViewController.swift
//  Agronom
//
//  Created by Grigory Sapogov on 19.11.2023.
//

import UIKit

final class StartCheckListEditViewController: ListViewController {
    
    var viewModel: StartCheckListEditViewModel?
    
    var checkListCompletion: ((UIViewController) -> Void)? = nil
    
    private let bottomView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let startCheckListButton: StartCheckListButton = StartCheckListButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Чек лист"
        self.view.backgroundColor = .systemBackground
        self.setupTableView()
        self.layout()
        self.setupAction()
        self.setupViewModel()
    }
    
    private func setupTableView() {
        self.tableView = UITableView(frame: .zero, style: .insetGrouped)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "TaskParameterCell", bundle: nil), forCellReuseIdentifier: "TaskParameterCell")
    }
    
    private let bottomStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    override func layout() {
        
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.bottomView)
        self.view.addSubview(self.bottomStackView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        self.startCheckListButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.bottomView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.bottomView.topAnchor.constraint(equalTo: self.tableView.bottomAnchor).isActive = true
        self.bottomView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.bottomView.addSubview(bottomStackView)
        
        self.bottomStackView.addArrangedSubview(self.startCheckListButton)
        
        self.bottomStackView.leadingAnchor.constraint(equalTo: self.bottomView.leadingAnchor, constant: 8).isActive = true
        self.bottomStackView.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 8).isActive = true
        self.bottomStackView.trailingAnchor.constraint(equalTo: self.bottomView.trailingAnchor, constant: -8).isActive = true
        self.bottomStackView.bottomAnchor.constraint(equalTo: self.bottomView.bottomAnchor, constant: -8).isActive = true
        
        self.startCheckListButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.bottomConstraint = self.bottomView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        self.bottomConstraint?.isActive = true
        
    }
    
    private func setupViewModel() {
        
        self.viewModel?.saveCompeltion = { [weak self] error in
            
            guard let self = self else { return }
            
            self.checkListCompletion?(self)
            
        }
        
    }
    
    private func setupAction() {
        
        self.startCheckListButton.action = { [weak self] in
            
            self?.viewModel?.save()
            
        }
        
    }
    
    @objc
    private func save() {
        
        self.viewModel?.save()
        
    }
    
}

extension StartCheckListEditViewController {
    
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
            
        case is CheckListOdometrRow:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskParameterCell", for: indexPath) as? TaskParameterCell else {
                return UITableViewCell()
            }
            
            cell.titleLabel.text = "Одометр"
            cell.textField.text = "\(self.viewModel?.cdItem.odometer_start ?? 0)"
            
            cell.textChanged = { [weak self] text in
                guard let value = text?.int else { return }
                self?.viewModel?.cdItem.odometer_start = value.int16
            }
            
            return cell
            
        case is CheckListLiquidRow:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskParameterCell", for: indexPath) as? TaskParameterCell else {
                return UITableViewCell()
            }
            
            cell.titleLabel.text = "Жидкость"
            cell.textField.text = "\(self.viewModel?.cdItem.liquied_start ?? 0)"
            
            cell.textChanged = { [weak self] text in
                guard let value = text?.int else { return }
                self?.viewModel?.cdItem.liquied_start = value.int16
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
    }
    
}

