//
//  SolaryListViewController.swift
//  Agronom
//
//  Created by Grigory Sapogov on 19.11.2023.
//

import UIKit
import CoreData

final class SolaryListViewController: ListViewController {
    
    var viewModel: SolaryListViewModel? = SolaryListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Зарплата"
        self.setupTableView()
        self.setupController()
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
        self.tableView.register(UINib(nibName: "SolaryCell", bundle: nil), forCellReuseIdentifier: "SolaryCell")
    }
    
    private func setupController() {
        
        let predicate = NSPredicate(format: "datetime_completed != nil")
        self.controller = Model.coreData.fetchedResultController(entity: CDTaskManager.entityName, sectionKey: nil, cacheName: nil, sortKey: "id", sortKeys: nil, sortDescriptors: nil, fetchPredicates: [predicate], ascending: true, batchSize: 50, fetchContext: nil)
        self.controller?.delegate = self
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let task = self.object(forIndexPath: indexPath) as? CDTaskManager else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SolaryCell", for: indexPath) as? SolaryCell else {
            return UITableViewCell()
        }
        
        cell.setup(item: task)
        
        return cell
        
    }
    
}
