//
//  OperationEditViewController.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import UIKit

final class OperationEditViewController: ListViewController, GrowingTableViewCellProtocol {
    
    var viewModel: OperationEditViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Операция"
        self.setupTableView()
        self.layout()
        self.setupNavigationButton()
    }
    
    private func setupTableView() {
        self.tableView = UITableView(frame: .zero, style: .insetGrouped)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "EditTextCell", bundle: nil), forCellReuseIdentifier: "EditTextCell")
    }
    
    private func layout() {
        
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    private func setupNavigationButton() {
        
        let button = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = button
        
    }
    
    @objc
    private func save() {
        
        self.viewModel?.save()
        
    }
    
}

extension OperationEditViewController {
    
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
        case is OperationEditNameRow:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditTextCell", for: indexPath) as? EditTextCell else {
                return UITableViewCell()
            }
            
            cell.titleLabel.text = "Операция"
            cell.growingDelegate = self
            cell.editChaged = { text in
                self.viewModel?.cdItem.name = text
            }
//            cell.titleLabel.isHidden = true
            
            return cell
            
        case is OperationEditDescriptionRow:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditTextCell", for: indexPath) as? EditTextCell else {
                return UITableViewCell()
            }
            
            cell.titleLabel.text = "Описание"
            cell.growingDelegate = self
            cell.editChaged = { text in
                self.viewModel?.cdItem.descriptionText = text
            }
//            cell.titleLabel.isHidden = true
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
    }
    
}
