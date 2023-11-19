//
//  ToolEditViewController.swift
//  Agronom
//
//  Created by Grigory Sapogov on 19.11.2023.
//

import UIKit

final class ToolEditViewController: ListViewController {
    
    var viewModel: ToolEditViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Оборудование"
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
    
    private func setupNavigationButton() {
        
        let button = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = button
        
    }
    
    @objc
    private func save() {
        
        self.viewModel?.save()
        
    }
    
}

extension ToolEditViewController {
    
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
        case is ToolEditNameRow:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditTextCell", for: indexPath) as? EditTextCell else {
                return UITableViewCell()
            }
            
            cell.titleLabel.text = "Наименование"
            cell.growingDelegate = self
            cell.editChaged = { text in
                self.viewModel?.cdItem.name = text
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
    }
    
}

