//
//  ViewController.swift
//  TodoApp
//
//  Created by Karin Prater on 04.02.21.
//

import UIKit
import Combine

class TodoListViewController: UIViewController {

    // use viewmodel to populate table
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = TaskListViewModel()
    var tasks = [String]() // Here we have to make a copy of tasks from our viewModel, because in this case we tryna use @Published var in our viewModel to display our data in tableView, but it emits new values in willSet block, that is why we have to make a copy to solve this problem
    
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        // add data stream that calls tableView.reloadData() when data changes
        viewModel.$tasks.sink { [unowned self] values in
            tasks = values
            self.tableView.reloadData()
        }.store(in: &subscriptions)
        
        
       
    }

    @IBSegueAction func addNewViewIsGoingToAppear(_ coder: NSCoder) -> AddNewViewController? {
        let controller = AddNewViewController(coder: coder)
        controller?.viewModel = viewModel
        return controller
    }
    
}

extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    
}
