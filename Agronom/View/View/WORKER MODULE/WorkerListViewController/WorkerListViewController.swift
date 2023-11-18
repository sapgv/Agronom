//
//  WorkerListViewController.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import UIKit
import CoreData

final class WorkerListViewController: ListViewController {
    
    var viewModel: WorkerListViewModel? = WorkerListViewModel()
    
    var selectCompletion: ((CDWorker, UIViewController) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Работники"
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
        self.tableView.register(UINib(nibName: "WorkerCell", bundle: nil), forCellReuseIdentifier: "WorkerCell")
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
        
        self.controller = Model.coreData.fetchedResultController(entity: CDWorker.entityName, sectionKey: nil, cacheName: nil, sortKey: "id", sortKeys: nil, sortDescriptors: nil, fetchPredicates: nil, ascending: true, batchSize: 50, fetchContext: nil)
        self.controller?.delegate = self
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = self.object(forIndexPath: indexPath) as? CDWorker else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorkerCell", for: indexPath) as? WorkerCell else {
            return UITableViewCell()
        }
        
        cell.setup(item: item)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        guard let item = self.object(forIndexPath: indexPath) as? CDWorker else { return }
        
        selectCompletion?(item, self)
        
    }
    
}