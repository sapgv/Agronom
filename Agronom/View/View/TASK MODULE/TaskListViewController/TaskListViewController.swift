//
//  TaskListViewController.swift
//  Agronom
//
//  Created by Grigory Sapogov on 17.11.2023.
//

import UIKit
import CoreData

final class TaskListViewController: ListViewController {
    
    var viewModel: TaskListViewModel? = TaskListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Задачи"
        self.setupTableView()
        self.setupController()
        self.layout()
        self.updateData()
        self.setupRefreshControll()
        self.setupViewModel()
        self.updateControllerResults()
        self.setupNavigationButton()
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
        self.tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
    }
    
    @objc
    private func add() {
        
        let viewContext = Model.coreData.createChildContextFromCoordinator(for: .mainQueueConcurrencyType, mergePolicy: .mergeByPropertyObjectTrump)
        
        let cdTaskManager = CDTaskManager(context: viewContext)
        cdTaskManager.id = Int16.random(in: 0...Int16.max)
        
        let viewModel = TaskEditViewModel(cdTaskManager: cdTaskManager, viewContext: viewContext)
        
        let viewController = TaskEditViewController()
        viewController.viewModel = viewModel
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    private func setupNavigationButton() {
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(add))
        self.navigationItem.rightBarButtonItem = addButton
        
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
        
        self.controller = Model.coreData.fetchedResultController(entity: CDTaskManager.entityName, sectionKey: nil, cacheName: nil, sortKey: "id", sortKeys: nil, sortDescriptors: nil, fetchPredicates: nil, ascending: true, batchSize: 50, fetchContext: nil)
        self.controller?.delegate = self
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let task = self.object(forIndexPath: indexPath) as? CDTaskManager else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
        
        cell.setup(task: task)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: "Редактировать") { [weak self] _, _, completion in
            guard let cdItem = self?.object(forIndexPath: indexPath) as? CDTaskManager else { return }
            self?.edit(task: cdItem)
            completion(true)
        }
        action.backgroundColor = .systemYellow
        
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
    func edit(task: CDTaskManager) {
        
        let viewContext = Model.coreData.createChildContextFromCoordinator(for: .mainQueueConcurrencyType, mergePolicy: .mergeByPropertyObjectTrump)
        
        let cdTaskManager = viewContext.objectInContext(CDTaskManager.self, objectID: task.objectID)!
        cdTaskManager.id = Int16.random(in: 0...Int16.max)
        
        let viewModel = TaskEditViewModel(cdTaskManager: cdTaskManager, viewContext: viewContext)
        
        let viewController = TaskEditViewController()
        viewController.viewModel = viewModel
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}
