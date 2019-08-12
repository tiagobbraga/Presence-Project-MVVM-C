//
//  ListViewController.swift
//  Personal
//
//  Created by Tiago Braga on 11/21/18.
//  Copyright © 2018 Physis. All rights reserved.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoUsersLabel: UILabel!
    
    internal var viewModel: StudentListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fecthData()
    }
    
    // MARK: Internal Methods
    internal func setup(viewModel: StudentListViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Private Methods
    private func bindVM() {
        self.title = self.viewModel.titlePage
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: self.viewModel.textNewUser, style: .done, target: self, action: #selector(onGoNewUser))
        self.infoUsersLabel.text = self.viewModel.textNoDataWarning
        
        self.viewModel.hasContent.bindAndFire { (value) in
            self.tableView.isHidden = !value
            self.infoUsersLabel.isHidden = value
        }
        
        self.viewModel.reloadTableViewClosure = {
            self.tableView.reloadData()
        }
    }
    
    private func createNewPresence(viewModel: StudentCellViewModel) {
        let title = "Confirmar presença"
        let message = "Marcar presença para \(viewModel.name)?"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let presence = UIAlertAction(title: "SIM", style: .default) { (alertAction) in
            self.viewModel.makePresente(viewModel: viewModel)
        }
        
        alertController.addAction(cancel)
        alertController.addAction(presence)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Actions
    @objc private func onGoNewUser() {
        self.viewModel.didTappedNewStudent()
    }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.viewModel.getCellViewModel(row: indexPath.row)
        
        let identifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! StudentTableViewCell
        
        cell.viewModel = viewModel
        
        cell.presenceButtonHandler = {
            self.createNewPresence(viewModel: viewModel)
        }
        
        return cell
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = self.viewModel.getCellViewModel(row: indexPath.row)
        self.viewModel.didTappedStudent(viewModel.student) //coordinator
    }
    
}
