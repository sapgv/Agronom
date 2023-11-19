//
//  ToolListViewController.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import UIKit
import CoreData

final class ToolListViewController: ListViewController {
    
    var viewModel: ToolListViewModel? = ToolListViewModel()
    
    var selectCompletion: ((CDTool, UIViewController) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Оборудование"
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
        let cdItem = CDTool(context: viewContext)
        let viewModel = ToolEditViewModel(viewContext: viewContext, cdItem: cdItem)
        
        let viewController = ToolEditViewController()
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
        self.tableView.register(UINib(nibName: "ToolCell", bundle: nil), forCellReuseIdentifier: "ToolCell")
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
        
        self.controller = Model.coreData.fetchedResultController(entity: CDTool.entityName, sectionKey: nil, cacheName: nil, sortKey: "id", sortKeys: nil, sortDescriptors: nil, fetchPredicates: nil, ascending: true, batchSize: 50, fetchContext: nil)
        self.controller?.delegate = self
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = self.object(forIndexPath: indexPath) as? CDTool else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToolCell", for: indexPath) as? ToolCell else {
            return UITableViewCell()
        }
        
        cell.setup(item: item)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        guard let item = self.object(forIndexPath: indexPath) as? CDTool else { return }
        
        selectCompletion?(item, self)
        
    }
    
}
