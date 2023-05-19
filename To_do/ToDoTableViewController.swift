//
//  ToDoTableViewController.swift
//  To_do
//
//  Created by Catarau, Bianca on 13.04.2023.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let viewModel = ToDoTableViewModel()
    
    
    lazy var createNewButton: UIButton = {
        var button = UIButton()
        button.tintColor = .red
        button.backgroundColor = .green
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        
        button.addTarget(self, action: #selector(createNewToDo), for:.touchUpInside)
        
        return button
    }()
    
    lazy var filterOrSort: UIButton = {
        var button = UIButton()
        button.tintColor = .red
        button.backgroundColor = .green
        button.setImage(UIImage(systemName: "line.horizontal.3.decrease.circle.fill"), for: .normal)
        button.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        
        button.addTarget(self, action: #selector(filterBy), for:.touchUpInside)
        
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigation Item.rightBarButtonItem = self.editButtonItem
        viewModel.delegate = self
        configureTableView()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
    }
    // MARK: - Selectors
    
    @objc func createNewToDo() {
        let vc = CreateToDoViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    @objc func filterBy() {
        let vc = StatusChangeViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    // MARK: - Helper functions
    func configureTableView() {
        tableView.backgroundColor = .lightGray
        
        tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.reuseId)
        tableView.rowHeight = 75
        tableView.separatorColor = .systemRed
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.tableFooterView = UIView()
        
        //Create new to do item
        
        tableView.addSubview(createNewButton)
        createNewButton.anchor(bottom: tableView.safeAreaLayoutGuide.bottomAnchor, right: tableView.safeAreaLayoutGuide.rightAnchor, paddingBottom: 16, paddingRight: 16, width: 56, height: 56)
        createNewButton.layer.cornerRadius = 56/2
        createNewButton.alpha = 1
        
        
    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UITableViewDelegate/UITableViewDataSource
extension ToDoTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if case .dataLoaded(let data) = viewModel.state{
            return data.count
        } else {
            return 0
        }
    }
    //populeaza celulele
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //returns a cell that was previously registered or reuses a cell that exits the screen
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.reuseId, for: indexPath) as? ToDoCell else { return UITableViewCell()}


        if case .dataLoaded(let data) = viewModel.state{
            let model = data[indexPath.row]
            //seteaza val pt celule folosind o METODA func din todocell
            cell.configure(model: model, delegate: self)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //update status of cell from incomplete to finished
        //ca sa nu ramana highlighted
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch viewModel.state {
        case .loading:
            break
        case .dataLoaded(let data):
            //1. get UserTask model from data using the indexPath.row
            let userTask = data[indexPath.row]

            //2. create StatusChangeViewController using StatusChangeViewModel created at step 2
            let vc = StatusChangeViewController()
            
            //3. create the StatusChangeViewModel using the model obtained from step 1
            let viewModel = StatusChangeViewModel(userTask: userTask, delegate: vc)
            
            vc.viewModel = viewModel
            //4. present StatusChangeViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
        case .error(_):
            break
        case .empty:
            break
        }
    }
}

extension ToDoTableViewController: ToDoTableViewModelDelegate {
    func dataNeedsUpdate() {
        tableView.reloadData()
    }
}

extension ToDoTableViewController: ToDoCellDelegate {
    func updateState(cell: ToDoCell) {
        if let index = tableView.indexPath(for: cell)?.row {
            viewModel.updateState(index: index)
        }
    }
}
