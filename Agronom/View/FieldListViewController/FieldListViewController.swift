//
//  FieldListViewController.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import UIKit
import CoreData

final class FieldListViewController: ListViewController {
    
    var viewModel: FieldListViewModel? = FieldListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Поля"
        self.setupTableView()
        self.setupController()
        self.layout()
        self.updateData()
        self.setupRefreshControll()
        self.setupViewModel()
        self.updateControllerResults()
    }
    
    private func setupViewModel() {
        
        self.viewModel?.updateCompletion = { [weak self] error in
            
            defer {
                self?.refreshControll?.endRefreshing()
                self?.updateControllerResults()
            }
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self?.tableView.reloadData()
            
        }
        
    }
    
    private func setupTableView() {
        self.tableView = UITableView(frame: .zero, style: .insetGrouped)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "FieldCell", bundle: nil), forCellReuseIdentifier: "FieldCell")
    }
    
    
    
    private func setupRefreshControll() {
        
        self.refreshControll = UIRefreshControl()
        self.refreshControll?.addTarget(self, action: #selector(updateData), for: .valueChanged)
        self.tableView.refreshControl = refreshControll
        
    }
    
    @objc
    private func updateData() {
        
        self.viewModel?.updateData()
        
    }
    
    private func setupController() {
        
        self.controller = Model.coreData.fetchedResultController(entity: CDField.entityName, sectionKey: nil, cacheName: nil, sortKey: "id", sortKeys: nil, sortDescriptors: nil, fetchPredicates: nil, ascending: true, batchSize: 50, fetchContext: nil)
        self.controller?.delegate = self
        
    }
    
    
    private func layout() {
        
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = self.object(forIndexPath: indexPath) as? CDField else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FieldCell", for: indexPath) as? FieldCell else {
            return UITableViewCell()
        }
        
        cell.setup(item: item)
        
        return cell
        
    }
    
    
}
