//
//  NewUserViewController.swift
//  Personal
//
//  Created by Tiago Braga on 11/21/18.
//  Copyright © 2018 Physis. All rights reserved.
//

import UIKit
import MultiSelectSegmentedControl

class NewEditUserViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var firstNameTextField: UITextField! {
        didSet {
            firstNameTextField.addTarget(self, action: #selector(onFirstnameDidChange), for: .editingChanged)
        }
    }
    @IBOutlet weak var lastNameTextField: UITextField! {
        didSet {
            lastNameTextField.addTarget(self, action: #selector(onLastnameDidChange), for: .editingChanged)
        }
    }
    @IBOutlet weak var daysMultiSelectSegmentedControl: MultiSelectSegmentedControl! {
        didSet {
            daysMultiSelectSegmentedControl.delegate = self
        }
    }
    @IBOutlet weak var hourTextField: UITextField!
    
    @IBOutlet weak var containerHourView: UIView!
    @IBOutlet weak var hourDatePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var desactiveButton: UIButton!
    
    private var selectedTextField: UITextField? = nil
    internal var viewModel: StudentViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onBackNavigate))
//        self.navigationItem.leftBarButtonItem = backButton
        
        self.bindVM()
    }
    
    func setup(viewModel: StudentViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Private Methods
    private func bindVM() {
        self.title = self.viewModel?.title
        
        self.firstNameTextField?.text = self.viewModel?.firstname ?? ""
        self.lastNameTextField?.text = self.viewModel?.lastname ?? ""
        self.daysMultiSelectSegmentedControl.selectedSegmentIndexes = self.viewModel?.days ?? IndexSet.init()
        self.hourTextField?.text = self.viewModel?.hour.value
        self.desactiveButton?.isHidden = !(self.viewModel?.editableContent ?? false)
        
        self.viewModel?.hour.bindAndFire({ [weak self] hour in
            self?.hourTextField?.text = hour
        })
        
        self.viewModel?.hideContainerHour.bindAndFire({ [weak self] hide in
            self?.containerHourView.isHidden = hide
        })
        
        self.viewModel?.validInputData.bindAndFire({ [weak self] valid in
            self?.saveButton.isEnabled = valid
        })
    }

    // MARK: Actions
    @objc private func onFirstnameDidChange(textField: UITextField) {
        self.viewModel?.firstname = textField.text ?? ""
    }
    
    @objc private func onLastnameDidChange(textField: UITextField) {
        self.viewModel?.lastname = textField.text ?? ""
    }

    @IBAction func onAdd(_ sender: Any) {
        self.viewModel?.submitStudent()
    }
    
    @IBAction func onDesactiveStudent(_ sender: Any) {
        self.viewModel?.desactiveStudent()
    }
    
    @IBAction func onCancelSetHour(_ sender: Any) {
        self.viewModel?.hideContainerHour.value = true
    }
    
    @IBAction func onSetHour(_ sender: Any) {
        self.viewModel?.hideContainerHour.value = true
        self.viewModel?.date = self.hourDatePicker.date
    }
    
    @IBAction func onChangeHour(_ sender: Any) {
        self.viewModel?.date = self.hourDatePicker.date
    }
    
//    @objc private func onBackNavigate() {
//        self.viewModel?.goBack?()
//    }
    
}

extension NewEditUserViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.viewModel?.hideContainerHour.value = true
        
        if textField == self.hourTextField {
            self.selectedTextField?.resignFirstResponder()
            self.selectedTextField = textField
            self.viewModel?.hideContainerHour.value = false
//            self.viewModel?.date = self.hourDatePicker.date
            return false
        }
        
        self.selectedTextField = textField
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension NewEditUserViewController: MultiSelectSegmentedControlDelegate {
    
    func multiSelect(_ multiSelectSegmentedControl: MultiSelectSegmentedControl, didChangeValue value: Bool, at index: UInt) {
        self.viewModel?.days = multiSelectSegmentedControl.selectedSegmentIndexes
    }
    
}
