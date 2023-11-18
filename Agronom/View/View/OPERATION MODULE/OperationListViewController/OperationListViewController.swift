//
//  OperationListViewController.swift
//  Agronom
//
//  Created by Grigory Sapogov on 17.11.2023.
//

import UIKit
import CoreData

final class OperationListViewController: ListViewController {
    
    var viewModel: OperationListViewModel? = OperationListViewModel()
    
    var selectCompletion: ((CDTaskOperation, UIViewController) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Операции"
        self.setupTableView()
        self.setupController()
        self.layout()
        self.updateData()
        self.setupRefreshControll()
        self.setupViewModel()
        self.updateControllerResults()
        self.setupNavigationButton()
        
    }
    
    private func setupNavigationButton() {
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(add))
        self.navigationItem.rightBarButtonItem = addButton
        
    }
    
    @objc
    private func add() {
        
        let viewContext = Model.coreData.createChildContextFromCoordinator(for: .mainQueueConcurrencyType, mergePolicy: .mergeByPropertyObjectTrump)
        let cdItem = CDTaskOperation(context: viewContext)
        let viewModel = OperationEditViewModel(viewContext: viewContext, cdItem: cdItem)
        
        let viewController = OperationEditViewController()
        viewController.viewModel = viewModel
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
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
        self.tableView.register(UINib(nibName: "OperationCell", bundle: nil), forCellReuseIdentifier: "OperationCell")
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
        
        self.controller = Model.coreData.fetchedResultController(entity: CDTaskOperation.entityName, sectionKey: nil, cacheName: nil, sortKey: "id", sortKeys: nil, sortDescriptors: nil, fetchPredicates: nil, ascending: true, batchSize: 50, fetchContext: nil)
        self.controller?.delegate = self
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = self.object(forIndexPath: indexPath) as? CDTaskOperation else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OperationCell", for: indexPath) as? OperationCell else {
            return UITableViewCell()
        }
        
        cell.setup(item: item)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        guard let item = self.object(forIndexPath: indexPath) as? CDTaskOperation else { return }
        
        selectCompletion?(item, self)
        
    }
    
    
}
