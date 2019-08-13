//
//  ListPresenceViewController.swift
//  Personal
//
//  Created by Tiago Braga on 11/22/18.
//  Copyright © 2018 Physis. All rights reserved.
//

import UIKit

class ListPresenceViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    
    internal var viewModel: PresenceListViewModel!
    private var updateStudentViewModel: UpdateStudentViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onBackNavigate))
//        self.navigationItem.leftBarButtonItem = backButton
        
        self.bindVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.filterData()
    }
    
    // MARK: Internal Methods
    internal func setup(viewModel: PresenceListViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Private Methods
    private func bindVM() {
        self.viewModel.titlePage.bindAndFire { (title) in
            self.title = title
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: self.viewModel.textEditUser, style: .done, target: self, action: #selector(onEditUser))
        
        self.viewModel.reloadTableViewClosure = {
            self.tableView.reloadData()
        }
    }
    
    // MARK: Actions
    @objc private func onEditUser() {
        self.updateStudentViewModel = UpdateStudentViewModel(student: self.viewModel.student)
        self.updateStudentViewModel?.updatedStudent = { [weak self] student in
            self?.viewModel.student = student
            self?.viewModel.goBack()
        }
        self.viewModel.didTappedEditStudent(self.updateStudentViewModel!)
    }
    
//    @objc private func onBackNavigate() {
//        self.viewModel.goBack()
//    }

}

extension ListPresenceViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfGroups
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInGroup(index: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let presence = self.viewModel.getModel(index: indexPath.section, row: indexPath.row)

        let identifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = presence.date.formatDate(format: "MMM d, yyyy - HH:mm")

        return cell
    }
    
}

extension ListPresenceViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.titleForSection(index: section)
    }

}
